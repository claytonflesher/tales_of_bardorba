require_relative "enemy_chooser"
require_relative "combat"
require_relative "input"
require_relative "saved_game"
require_relative "tavern_menu"


module TalesOfBardorba
  class Game
    def initialize(player)
      @player         = player
      @enemy_chooser  = EnemyChooser.new
      @in_village     = true
    end

    attr_reader :player, :enemy_chooser, :in_village
    private :player, :enemy_chooser, :in_village

    def play
      until player.dead?
        make_a_choice
      end
    end

    private

    def make_a_choice
      if in_village?
        village_action_choice
      else
        world_action_choice
      end
    end

    def village_action_choice
      @in_village = true
      puts "You find yourself in a rustic village in the middle of a strange but sexy world."
      response = Input.new(:village_choice).get_char
      village_action(response)
    end

    def village_action(response)
      case response
      when "E"
        explore_world
      when "T"
        TavernMenu.new(player).look_around
      when "S"
        save
      when "Q"
        quit
      end
    end

    def explore_world
      @in_village = false
      puts "As you step out into the world, you have a newfound sense of purpose and vim."
      determine_world_event
    end

    def determine_world_event
      #Add random selection between enemy combat and npc_encounter here. Heavily favor combat.
      #if random outcome
      # npc_encounter
      #else
      enemy = enemy_chooser.choose
      puts "Suddenly, you encounter #{enemy.name}!"
      Combat.new(player, enemy).resolve
      #end
      make_a_choice
    end

    def world_action_choice
      input = Input.new(:world_choice).get_char
      case input
      when "R"
        @in_village = true
        make_a_choice
      when "C"
        determine_world_event
      end
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
      puts "As you enter the tavern, you look around."
      sleep 0.5
      tavern_choice
    end

    def go_to_shop
      #FIXME
    end

    def npc_encounter
      #FIXME
    end

    def in_village?
      in_village
    end
  end
end
