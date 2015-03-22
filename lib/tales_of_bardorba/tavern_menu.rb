require_relative "input"
require_relative "conversation"

module TalesOfBardorba
  class TavernMenu
    def initialize(player)
      @player = player
    end

    attr_reader :player

    def look_around
      puts "Behind the bar stands a grim looking dwarf wiping down a glass.\nJust exiting the kitchen is the red-faced innkeep, carrying a bill in one hand and a plate of stewed rabbit in the other."
      patrons
      input = Input.new(:tavern).get_char
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
        Game.new(player).play
      end
    end

    def chat_in_tavern_with(npc)
      Conversation.new(player).send(npc)
      sleep 0.5
      look_around
    end
  end
end
