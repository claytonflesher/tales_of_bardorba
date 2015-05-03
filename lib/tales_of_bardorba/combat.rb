require_relative "combat_input"
require_relative "spell"
require_relative "ability"

module TalesOfBardorba
  class Combat
    def initialize(player, enemy)
      @player   = player
      @enemy    = enemy
      @ran_away = false
    end

    attr_reader :player, :enemy, :ran_away
    private :player, :enemy, :ran_away

    def resolve
      until player.dead? || enemy.dead? || ran_away?
        round
      end
      if player.dead?
        puts "#{player.name} died."
        exit
      elsif enemy.dead?
        win
      end
      player.reset_stats
    end

    private

    def win
      puts "Congrats, you vanquished #{enemy.name}."
      player.gain_experience
      player.gain_money(enemy.money)
      puts "#{player.name} recieves $#{enemy.money}.\n#{player.name} now has $#{player.money}."
    end

    def round
      input = CombatInput.new(player)
      input.query_user
      [player, enemy].shuffle.each do |actor|
        if actor == player && !player.dead?
          resolve_round(player, enemy, input)
        elsif actor == enemy && !enemy.dead?
          resolve_round(enemy, player)
        end
      end
      puts "#{player.name}'s current hp is #{player.hp}\n\n"
    end

    def resolve_round(target, opponent, input = nil)
      status_effect_event(target, opponent, "before")
      if target.status_effects.any? { |status_effect| status_effect.is_a?(AfraidStatusEffect) }
        run_away(target, opponent)
      else
        resolve_status_effects(target, opponent, input)
      end
      status_effect_event(target, opponent, "after")
    end

    def status_effect_event(target, opponent, time)
      if time == "before"
        target.status_effects.each do |status_effect|
          status_effect.apply_before_turn(target)
        end
      elsif time == "after"
        target.status_effects.each do |status_effect|
          status_effect.apply_after_turn(target)
        end
      end
    end

    def resolve_status_effects(target, opponent, input)
      if target.status_effects.all? { |status_effect| status_effect.can_act? }
        if target == @player
          perform_player_action(input)
        elsif target == @enemy
          attack(@enemy, @player)
        end
      end
    end

    def perform_player_action(input)
      case input.action
      when "A"
        attack(@player, @enemy)
      when "B"
        Ability.new(@player, @enemy, input.ability).resolve
      when "S"
        Spell.new(@player, @enemy, input.spell).resolve
      when "R"
        run_away(@player, @enemy)
      end
    end

    def attack(attacker, target)
      if hit?(attacker, target)
        damage = attacker.damage(target)
        target.take_damage(damage)
        puts "#{attacker.name} hit #{target.name} for #{damage} hp."
      else
        puts "#{attacker.name} missed #{target.name}."
      end
    end

    def hit?(attacker, target)
      modified_hit = attacker.status_effects.inject(attacker.hit) { |sum, se| 
        sum + se.hit_modifier(attacker) }
      modified_defense = target.status_effects.inject(target.defense) { |sum, se| 
        sum + se.defense_modifier(target) }
      attack       = rand(1..(modified_hit - modified_defense))
      if attack == nil
        return false
      else
        return attack > 3
      end
    end

    def run_away(coward, opponent)
      attempt     = rand(3)
      if attempt > 0 || !opponent.status_effects.all? { |status_effect| status_effect.can_act? }
        puts "#{coward.name} ran away like a coward.\nCongratulations, you live to see another day."
        @ran_away = true
      else
        puts "#{coward.name} failed to escape.\n#{coward.name} wasted a turn."
      end
    end

    def ran_away?
      @ran_away
    end
  end
end
