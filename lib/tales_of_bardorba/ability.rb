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
      send(@ability_chosen.downcase)
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



