require_relative "input"

module TalesOfBardorba
  class Combat
    def initialize(player, enemy)
      @player   = player
      @enemy    = enemy
      @ran_away = false
    end

    attr_reader :player, :enemy, :ran_away

    def resolve
      player.reset_encounter_spells
      until player.dead? || enemy.dead? || ran_away?
        round
      end
      if player.dead?
        puts "#{player.name} died."
      elsif enemy.dead?
        puts "Congrats, you vanquished #{enemy.name}."
      end
    end

    def round
      responses = get_player_action
      [player, enemy].shuffle.each do |actor|
        if actor == player && !player.dead?
          perform_player_action(responses.first, responses.last)
        elsif actor == enemy && !enemy.dead?
          perform_enemy_action
        end
      end
      puts "#{player.name}'s current hp is #{player.hp}\n\n"
    end

    def get_player_action
      response = Input.new("[A]ttack\n[S]pell\n[R]un\n?", %w[A S R]).get_char
      spell_name = nil
      if response == "S"
        spell_name = spell(player)
      end
      return [response, spell_name]
    end

    
    def perform_player_action(action, spell_name)
      case action
      when "A"
        attack(player, enemy)
      when "S"
        resolve_spell(spell_name, player, enemy)
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

    def spell(player)
      at_will   = player.at_will_spells_list
      encounter = player.encounter_spells_list
      puts "Your available at-will spells are #{at_will.join(", ")}"
      if player.encounter_spell_available?
        puts "Your available encounter spells are #{encounter.join(", ")}"
      end
      Input.new("Which spell would you like to use?", at_will + encounter).get_line
    end

    def resolve_spell(spell, player, enemy)
      case spell
      when "Zap"
        enemy.stunned_for = rand(1..3)
        puts "The enemy is stunned for #{enemy.stunned_for} turn(s)."
      when "Sap"
        if player.encounter_spell_available?
          enemy.defense -= 1
          player.encounter_spells -= 1
          puts "The enemy's defenses have been weakened."
        else
          puts "You're out of encounter spells.\nYou just wasted a turn."
        end
      end
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
