module TalesOfBardorba
  class Player
    BASE_HIT      = 10
    BASE_DEFENSE  = 2

    def initialize(name, hp = 100, hit = BASE_HIT, defense = 2, encounter_spells = 1, encounter_abilities = 1)
      @name                 = name
      @hp                   = hp
      @hit                  = hit
      @defense              = defense
      @encounter_spells     = 1
      @encounter_abilities  = 1
    end
  
    attr_accessor :hp, :hit, :defense, :encounter_spells, :encounter_abilities
    attr_reader :defense, :name

    def damage
      rand(1..6)
    end

    def dead?
      hp < 1
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

    def at_will_abilities_list
      %w[Sweep]
    end

    def encounter_abilities_list
      %W[Focus]
    end

    def reset_stats
      @hit                  = BASE_HIT
      @defense              = BASE_DEFENSE
      @encounter_spells     = 1
      @encounter_abilities  = 1
    end

    def encounter_spell_available?
      encounter_spells > 0
    end

    def encounter_ability_available?
      encounter_abilities > 0
    end
  end
end
