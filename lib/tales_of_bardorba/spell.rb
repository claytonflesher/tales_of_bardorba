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
      send(@spell_chosen.downcase)
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
