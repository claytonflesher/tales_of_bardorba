require_relative "input"

module TalesOfBardorba
  class Spell
    def initialize(player, enemy, spell_chosen)
      @player       = player
      @enemy        = enemy
      @spell_chosen = spell_chosen
    end

    attr_reader :player, :enemy, :spell_chosen

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
