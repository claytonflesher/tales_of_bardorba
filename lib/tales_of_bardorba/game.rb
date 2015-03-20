require_relative "enemy_chooser"
require_relative "combat"
require_relative "input"
require_relative "saved_game"
require_relative "conversation"


module TalesOfBardorba
  class Game
    def initialize(player)
      @player         = player
      @enemy_chooser  = EnemyChooser.new
      @in_village     = true
    end

    attr_reader :player, :enemy_chooser, :in_village

    def play
      until player.dead?
        make_a_choice
      end
    end

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
      response = Input.new("What would you like to do?\n\n[E]xplore the world outside the village.\nGo to the local [T]avern\n[S]ave your game.\n[Q]uit with your tail between your legs.\n?", %w[E T S Q]).get_char
      village_action(response)
    end

    def village_action(response)
      case response
      when "E"
        explore_world
      when "T"
        go_to_tavern
        player.restore
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
      input = Input.new("That over, what would you like to do now?\n[R]eturn to the village.\n[C]ontinue exploring the world.", %w[R C]).get_char
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

    def tavern_choice
      puts "Behind the bar stands a grim looking dwarf wiping down a glass.\nJust exiting the kitchen is the red-faced inkeep, carrying a bill in one hand and a plate of stewed rabbit in the other."
      patrons
      input = Input.new("What would you like to do?\nSpeak to the [B]artender.\nGet the attention of the [I]nnkeep.\nApproach one of the [P]atrons.\n[L]eave the tavern.", %[B I P L]).get_char
      tavern_action(input)
    end

    def patrons
      # These are the only patrons for now. At a later point, I'll create a database of patrons and a Patrons object, with a quest tied to each npc. What patrons will appear will be determined by the quests that are currently available.
      puts "Among the patrons you see a group of angry-looking farmers, a well-armed man in a ragged cloak, and a young boy attempting to hold back tears."
    end

    def tavern_action(input)
      case input
      when "B"
        chat_in_tavern_with(:bartender)
      when "I"
        chat_in_tavern_with(:innkeep)
      when "P"
        chat_in_tavern_with(:patron)
      when "L"
        village_action_choice
      end
    end

    def chat_in_tavern_with(npc)
      Conversation.new(player).self(npc)
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
