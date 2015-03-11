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

    def resolve
      until player.dead? || enemy.dead? || ran_away?
        round
      end
      if player.dead?
        puts "#{player.name} died."
        exit
      elsif enemy.dead?
        puts "Congrats, you vanquished #{enemy.name}."
      end
      player.reset_stats
      player.gain_experience
    end

    def round
      input = CombatInput.new(player)
      input.query_user
      [player, enemy].shuffle.each do |actor|
        if actor == player && !player.dead?
          resolve_player_round(input)
        elsif actor == enemy && !enemy.dead?
          resolve_enemy_round
        end
      end
      puts "#{player.name}'s current hp is #{player.hp}\n\n"
    end

    def resolve_player_round(input)
      resolve_fright_round(player)
      if player.afraid?
        run_away(player, enemy)
      else
        resolve_player_status_effects(input)
        resolve_poison_round(player)
      end
    end

    def resolve_player_status_effects(input)
      if player.stunned_for > 0
        resolve_stunned_round(player)
      elsif player.blinded_for > 0
        resolve_blinded_round(player, enemy, input)
      elsif player.asleep?
        resolve_sleep_round(player)
        puts "#{player.name} is asleep."
      else
        perform_player_action(input)
      end
    end

    def perform_player_action(input)
      case input.action
      when "A"
        attack(player, enemy)
      when "B"
        Ability.new(player, enemy, input.ability).resolve
      when "S"
        Spell.new(player, enemy, input.spell).resolve
      when "R"
        run_away(player, enemy)
      end
    end

    def resolve_enemy_round
      resolve_fright_round(enemy)
      if enemy.afraid?
        run_away(enemy, player)
      else
        resolve_enemy_status_effects
        resolve_poison_round(enemy)
      end
    end

    def resolve_enemy_status_effects
      if enemy.stunned_for > 0 
        resolve_stunned_round(enemy)
      elsif enemy.blinded_for > 0
        resolve_blinded_round(enemy, player)
      elsif enemy.asleep?
        resolve_sleep_round(enemy)
      else
        attack(enemy, player)
      end
    end


    def resolve_blinded_round(victim, opponent, input = nil)
      puts "#{victim.name} is blinded."
      if victim == player
        perform_player_action(input)
      else
        attack(victim, opponent)
      end
      victim.blinded_for -= 1
      if victim.blinded_for == 0; victim.reset_hit; end
    end

    def resolve_stunned_round(target)
      puts "#{target.name} is stunned."
      target.stunned_for -= 1
    end

    def resolve_sleep_round(victim)
      if victim.hp == victim.sleep_marker
        puts "#{victim.name} is asleep."
      else
        puts "#{victim.name} woke up!"
        victim.sleep = false
      end
    end

    def resolve_poison_round(victim)
      if victim.poisoned?
        victim.hp -= (victim.hpmax/10)
      end
    end

    def resolve_fright_round(victim)
      if victim.afraid?
        steel_will = rand(2)
        if steel_will == 0
          victim.afraid = false
          puts "#{victim.name} found the courage to continue fighting."
        end
      end
    end

    def attack(attacker, target)
      if hit?(attacker, target)
        damage = attacker.damage(target)
        target.hp -= damage
        puts "#{attacker.name} hit #{target.name} for #{damage} hp."
      else
        puts "#{attacker.name} missed #{target.name}."
      end
    end

    def hit?(attacker, target)
      attack = rand(1..(attacker.hit - target.defense))
      if attack == nil
        return false
      else
        return attack > 3
      end
    end

    def run_away(coward, opponent)
      attempt     = rand(3)
      if attempt > 0 || opponent.stunned_for > 0
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
