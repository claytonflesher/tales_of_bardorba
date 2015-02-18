require_relative "input"

module TalesOfBardorba
  class Ability
    def initialize(player, enemy, ability_chosen)
      @player         = player
      @enemy          = enemy
      @ability_chosen = ability_chosen
    end

    attr_reader :player, :enemy, :ability_chosen

    def resolve
      if player.at_will_abilities_list.include?(ability_chosen)
        execute_at_will
      elsif player.encounter_abilities_list.include?(ability_chosen)
        execute_encounter
      end
    end

    def execute_at_will
      case ability_chosen
      when "Sweep"
        sweep
      end
    end

    def execute_encounter
      case ability_chosen
      when "Focus"
        focus
      end
    end

    def sweep
      enemy.stunned_for = rand(1..3)
      puts "You sweep the leg.\n#{enemy.name} is stunned for #{enemy.stunned_for} turn(s).\n"
    end

    def focus
      player.hit += 5
      player.defense -= 1
      puts "You focus your inner strength, increasing your accuracy but sacrificing defense."
      player.encounter_abilities -= 1
    end
  end
end



