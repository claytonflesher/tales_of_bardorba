require_relative "input"

module TalesOfBardorba
  class CombatInput
    def initialize(player)
      @player       = player
      @action       = nil
      @ability      = nil
      @spell        = nil
    end
    
    attr_reader :player, :action, :ability, :spell

    def query_user
      query_parameters
      if @action == "B"
        @ability = choose_ability
      elsif @action == "S"
        @spell = choose_spell
      end
    end

    private

    def query_parameters
      if @player.magic == true && @player.feats == true
        @action = Input.new(:combat_query_all).get_char
      elsif @player.magic == true && @player.feats == false
        @action = Input.new(:combat_query_mage).get_char
      elsif @player.magic == false && @player.feats == true
        @action = Input.new(:combat_query_streetrat).get_char
      elsif @player.magic == false && @player.feats == false
        @action = Input.new(:combat_query_squire).get_char
      end
    end

    def choose_ability
      at_will   = player.at_will_abilities_list
      encounter = player.encounter_abilities_list
      available = at_will
      puts "Your available at will abilities are #{at_will.join(", ")}"
      if player.encounter_ability_available?
        puts "Your available encounter abilities are #{encounter.join(", ")}"
        available += encounter
      end
      Input.new(:combat_ability, available).get_line
    end

    def choose_spell
      at_will   = player.at_will_spells_list
      encounter = player.encounter_spells_list
      available = at_will
      puts "Your available at will spells are #{at_will.join(", ")}"
      if player.encounter_spell_available?
        puts "Your available encounter spells are #{encounter.join(", ")}"
        available += encounter
      end
      Input.new(:combat_spell, available).get_line
    end
  end
end
