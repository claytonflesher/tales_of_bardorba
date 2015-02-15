require_relative "enemy_chooser"
require_relative "combat"
require_relative "input"
require_relative "saved_game"


module TalesOfBardorba
  class Game
    def initialize(player)
      @player = player
      @enemy_chooser = EnemyChooser.new
    end

    attr_reader :player, :enemy_chooser

    def play
      until player.dead?
        make_a_choice
      end
    end

    def make_a_choice
      puts "You find yourself in a rustic village in the middle of a strange but sexy world."
      response = Input.new("What would you like to do?\n\n[E]xplore the world outside the village.\n[S]ave your game.\n[Q]uit with your tail between your legs.\n?", %w[E S Q]).get_char
      case response
      when "E"
        explore_world
      when "S"
        save
      when "Q"
        quit
      end
    end

    def explore_world
      puts "As you step out into the world, you have a newfound sense of purpose and vim."
      enemy = enemy_chooser.choose
      puts "Suddenly, you encounter #{enemy.name}!"
      Combat.new(player, enemy).resolve
    end

    def save
      SavedGame.new.create(player)
      puts "Game saved."
    end

    def quit
      puts "The villagers mock you mercilessly as you slink away."
      exit
    end
      
    def go_to_tavern
      #FIXME
    end

    def go_to_shop
      #FIXME
    end

  end
end

