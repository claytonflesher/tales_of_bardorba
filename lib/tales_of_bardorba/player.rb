require_relative "experience_table"

module TalesOfBardorba
  class Player
    EXPERIENCETABLE = ExperienceTable.new.load
    LEVELCAP        = 20

    def initialize(name = nil)
      @name                = name
      @encounter_spells    = 1
      @encounter_abilities = 1
      @level               = 1
      @experience          = 0
    end

    attr_accessor :hp, :hit, :defense, :encounter_spells, :encounter_abilities, :level, :experience
    attr_reader :name, :profession, :magic, :feats, :hpmax

    def assign_starting_stats(job)
      %i[hpmax hit defense magic feats hp].each do |name|
        instance_variable_set("@#{name}", job.send(name))
      end
      @default_hit     = job.hit
      @default_defense = job.defense
      @profession      = job.name
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

    def gain_experience
      if @level < LEVELCAP
        @experience +=1
        if raise_level?   
          puts raise_level?
          @level += 1
          puts "Congratulations, you've reached level #{@level}."
          if @level == 20
            puts "You have hit the level cap. You cannot gain any more levels."
          end
        end
      end
    end

    def raise_level?
      @experience == EXPERIENCETABLE[@level] 
    end
      

    def encounter_spell_available?
      encounter_spells > 0
    end

    def encounter_ability_available?
      encounter_abilities > 0
    end
  end
end
