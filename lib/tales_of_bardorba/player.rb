module TalesOfBardorba
  class Player
    def initialize(name, hp = 100, hit = 10, defense = 2, encounter_spells = 1)
      @name     = name
      @hp       = hp
      @hit      = hit
      @defense  = defense
      @encounter_spells = encounter_spells
    end
  
    attr_accessor :hp, :encounter_spells
    attr_reader :hit, :defense, :name

    def damage
      rand(1..6)
    end

    def dead?
      hp < 0
    end

    def to_s
      [name, hp, hit, defense].join("|")
    end

    def at_will_spells_list
      %w[Zap]
    end

    def encounter_spells_list
      %w[Sap]
    end

    def reset_encounter_spells
      encounter_spells = 1
    end

    def encounter_spell_available?
      encounter_spells > 0
    end

  end
end
