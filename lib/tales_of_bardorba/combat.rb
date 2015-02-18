require_relative "combat_input"
require_relative "spell"
require_relative "ability"

module TalesOfBardorba
  class Combat
    def initialize(player, enemy)
      @player   = player
      @enemy    = enemy
      @ran_away = false
      @spell    = nil
      @ability  = nil
    end

    attr_reader :player, :enemy, :ran_away, :answer, :spell, :ability

    def resolve
      reset_player_stats
      until player.dead? || enemy.dead? || ran_away?
        round
      end
      if player.dead?
        puts "#{player.name} died."
      elsif enemy.dead?
        puts "Congrats, you vanquished #{enemy.name}."
      end
    end

    def reset_player_stats
      player.reset_hit
      player.reset_defense
      player.reset_encounter_spells
      player.reset_encounter_abilities
    end

    def round
      responses = CombatInput.new(player).get_player_input
      [player, enemy].shuffle.each do |actor|
        if actor == player && !player.dead?
          perform_player_action(*responses)
        elsif actor == enemy && !enemy.dead?
          perform_enemy_action
        end
      end
      puts "#{player.name}'s current hp is #{player.hp}\n\n"
    end

    def perform_player_action(action, spell, ability)
      case action
      when "A"
        attack(player, enemy)
      when "B"
        Ability.new(player, enemy, ability).resolve
      when "S"
        Spell.new(player, enemy, spell).resolve
      when "R"
        run_away(enemy)
      end
    end

    def perform_enemy_action
      if enemy.stunned_for < 1
        attack(enemy, player)
      else
        puts "The enemy is stunned."
        enemy.stunned_for -= 1
      end
    end

    def attack(attacker, target)
      if hit?(attacker, target)
        damage = attacker.damage
        target.hp -= damage
        puts "#{attacker.name} hit #{target.name} for #{damage} hp."
      else
        puts "#{attacker.name} missed #{target.name}."
      end
    end

    def hit?(attacker, target)
      attack = rand(1..(attacker.hit - target.defense))
      attack > 3
    end

    def run_away(enemy)
      attempt     = rand(3)
      if attempt > 0 || enemy.stunned_for > 0
        puts "You run away like a coward.\nCongratulations, coward. You live to see another day."
        @ran_away = true
      else
        puts "You failed to escape.\nCongratulations, you just wasted a turn."
      end
    end

    def ran_away?
      ran_away
    end
  end
end
