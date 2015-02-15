require_relative "input"

module TalesOfBardorba
  class Spell
    def initialize(player, enemy)
      @player       = player
      @enemy        = enemy
      @spell_chosen = nil
    end

    attr_reader :player, :enemy, :spell_chosen

    def choose
      at_will   = player.at_will_spells_list
      encounter = player.encounter_spells_list
      abilities_available = at_will
      puts "Your available at-will spells are #{at_will.join(", ")}"
      if player.encounter_spell_available?
        puts "Your available encounter spells are #{encounter.join(", ")}"
        abilities_available += encounter
      end
        @spell_chosen = Input.new("Which spell would you like to use?", abilities_available).get_line
    end

    def resolve
      if player.at_will_spells_list.include?(spell_chosen)
        execute_at_will
      elsif player.encounter_spells_list.include?(spell_chosen)
        execute_encounter
      end
    end
    
    def execute_at_will
      case spell_chosen
      when "Zap"
        zap
      end
    end

    def execute_encounter
      case spell_chosen
      when "Sap"
        sap
      end
    end

    def zap
      enemy.stunned_for = rand(1..3)
      puts "You emit a jolt of electricity.\n#{enemy.name} is stunned for #{enemy.stunned_for} turn(s)."
    end

    def sap
        enemy.defense -= 1
        player.encounter_spells -= 1
    end
  end
end
