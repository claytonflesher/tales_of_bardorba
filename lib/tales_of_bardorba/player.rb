module TalesOfBardorba
  class Player
    def initialize(name, job)
      starting_stats(job)
      @default_hit          = job.hit
      @default_defense      = job.defense
      @name                 = name
      @profession           = job.job
      @encounter_spells     = 1
      @encounter_abilities  = 1
    end
  
    attr_accessor :hp, :hit, :defense, :encounter_spells, :encounter_abilities
    attr_reader :name, :profession, :magic, :feats, :hpmax

    def starting_stats(job)
      @hpmax   = job.hpmax
      @hit     = job.hit
      @defense = job.defense
      @magic   = job.magic
      @feats   = job.feats
      @hp      = job.hp
    end

    def stats
      stats = Hash.new
      stats["name"]       = @name
      stats["profession"] = @profession
      stats["hpmax"]      = @hpmax
      stats["hit"]        = @hit
      stats["defense"]    = @defense
      stats["magic"]      = @magic
      stats["feats"]      = @feats
      stats["hp"]         = @hp
      return stats
    end

    def damage(enemy)
      rand(1..6) + (@hit - enemy.defense)
    end

    def dead?
      hp < 1
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
      @hit                  = @default_hit
      @defense              = @default_defense
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
