require_relative "character"
require_relative "table"

module TalesOfBardorba
  class Player < Character
    EXPERIENCEFILE        = File.join(__dir__, "../../data/experience.txt")
    EXPERIENCETABLE       = Table.new(EXPERIENCEFILE).load_numbers
    ATWILLSPELLFILE       = File.join(__dir__, "../../data/at_will_spells.txt")
    ATWILLSPELLTABLE      = Table.new(ATWILLSPELLFILE).load_strings
    ENCOUNTERSPELLFILE    = File.join(__dir__, "../../data/encounter_spells.txt")
    ENCOUNTERSPELLTABLE   = Table.new(ENCOUNTERSPELLFILE).load_strings
    ATWILLABILITYFILE     = File.join(__dir__, "../../data/at_will_abilities.txt")
    ATWILLABILITYTABLE    = Table.new(ATWILLABILITYFILE).load_strings
    ENCOUNTERABILITYFILE  = File.join(__dir__, "../../data/encounter_abilities.txt")
    ENCOUNTERABILITYTABLE = Table.new(ENCOUNTERABILITYFILE).load_strings
    LEVELCAP              = 20
    #Is there some way to do this with a single method that I just feed arguments?

    def initialize(name = nil)
      @name                         = name
      @at_will_available            = 0
      @encounter_available          = 0
      @encounter_spells             = 1
      @default_encounter_spells     = 1
      @encounter_abilities          = 1
      @default_encounter_abilities  = 1
      @level                        = 1
      @experience                   = 0
      @status_effects               = [ ]
    end

    attr_reader :name, :hp, :hit, :defense, :encounter_spells,
                :encounter_abilities, :level, :experience, :profession, :magic,
                :feats, :hpmax, :at_will_available, :encounter_available,
                :status_effects

    def assign_starting_stats(job)
      %i[hpmax hit defense magic feats hp].each do |name|
        instance_variable_set("@#{name}", job.send(name))
      end
      @default_hit     = job.hit
      @default_defense = job.defense
      @profession      = job.name
    end

    def at_will_spells_list
      ATWILLSPELLTABLE[0..@at_will_available]
    end

    def encounter_spells_list
      ENCOUNTERSPELLTABLE[0..@encounter_available]
    end

    def at_will_abilities_list
      ATWILLABILITYTABLE[0..@at_will_available]
    end

    def encounter_abilities_list
      ENCOUNTERABILITYTABLE[0..@encounter_available]
    end

    def reset_stats
      @hit                  = @default_hit
      @defense              = @default_defense
      @encounter_spells     = @default_encounter_spells
      @encounter_abilities  = @default_encounter_abilities
      @status_effects = [ ]
    end

    def gain_experience
      if @level < LEVELCAP
        @experience +=1
        if raise_level?   
          @level += 1
          level_up
          puts "Congratulations, you've reached level #{@level}."
          reset_stats
          level_cap?
        end
      end
    end

    def level_cap?
      if @level == LEVELCAP
        puts "You have hit the level cap. You cannot gain any more levels."
      end
    end

    def raise_level?
      @experience >= EXPERIENCETABLE[@level] 
    end

    def level_up
      if @level % 5 == 0
        @encounter_available          += 1
        @default_encounter_spells     += 1
        @default_encounter_abilities  += 1
        @default_hit                  += 4
      else
        @at_will_available            += 1
        @default_defense              += 1
      end
      @hpmax                          += 5
    end

    def encounter_spell_available?
      @encounter_spells > 0
    end

    def encounter_ability_available?
      @encounter_abilities > 0
    end

    def use_encounter_spell
      @encounter_spells -= 1
    end

    def use_encounter_ability
      @encounter_abilities -= 1
    end
  end
end
