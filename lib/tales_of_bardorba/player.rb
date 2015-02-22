module TalesOfBardorba
  class Player
    def initialize(name, profession, stats)
      @stats                = stats
      @name                 = name
      @profession           = profession
      @hpmax                = stats[0]
      @hit                  = stats[1]
      @defense              = stats[2]
      @magic                = stats[3]
      @feats                = stats[4]
      @hp                   = stats[5]
      @encounter_spells     = 1
      @encounter_abilities  = 1
    end
  
    attr_accessor :hp, :hit, :defense, :encounter_spells, :encounter_abilities
    attr_reader :name, :profession, :magic, :feats, :hpmax

    def damage(enemy)
      rand(1..6) + (@hit - enemy.defense)
    end

    def dead?
      hp < 1
    end

    def to_s
      [name, profession, hpmax, hit, defense, magic, feats, hp].join("|")
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
      job                   = Job.new(profession)
      @hit                  = job.hit
      @defense              = job.defense
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
