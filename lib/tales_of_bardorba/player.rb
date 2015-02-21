require_relative "job"

module TalesOfBardorba
  class Player
    def initialize(name, profession, hpmax = nil, hp = nil, hit = nil, defense = nil, magic = nil, feats = nil)
      @name                 = name
      @profession           = profession
      @hpmax                = nil
      @hp                   = nil
      @hit                  = nil
      @defense              = nil
      @magic                = nil
      @feats                = nil
      @encounter_spells     = 1
      @encounter_abilities  = 1
    end
  
    attr_accessor :hp, :hit, :defense, :encounter_spells, :encounter_abilities
    attr_reader :name, :profession, :magic, :feats

    def set_stats
      job      = Job.new(profession)
      @hpmax   = job.hpmax
      @hp      = @hpmax
      @hit     = job.hit
      @defense = job.defense
      @magic   = job.magic
      @feats   = job.feats
    end

    def damage
      rand(1..6) + (@hit - enemy.defense)
    end

    def dead?
      hp < 1
    end

    def to_s
      [name, profession, hpmax, hp, hit, defense, magic, feats].join("|")
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
      @hit                  = 
      @defense              = 
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
