require_relative "input"
require_relative "drunk_status_effect"

module TalesOfBardorba
  class Conversation
    def initialize(player)
      @player = player
    end

    attr_reader :player
    
    def bartender
      cost = 10
      input = Input.new("Buy a drink? It'll cost you $#{cost}.\n[Y]es\n[N]o", %[Y N]).get_char
      if input == "Y"
        if player.money >= cost
          get_drunk(cost)
        else
          puts "You don't have enough money."
        end
      end
    end

    def get_drunk(cost)
      puts "The bartender pours you an ale."
      puts "'That'll be $#{cost}."
      player.lose_money(cost)
      sleep 0.5
      puts "It hits the spot.\nYou feel a little tipsy."
      player.apply_status_effect(DrunkStatusEffect.new(10))
    end

    def innkeep
      cost = 500
      input = Input.new("Get a room? It'll cost you $#{cost}.\n[Y]es\n[N]o", %[Y N]).get_char
      if input == "Y"
        if player.money >= cost
          get_room(cost)
        else
          puts "You don't have enough money."
        end
      end
    end
    
    def get_room(cost)
      puts "You pay $#{cost}."
      player.lose_money(cost)
      puts "You sleep for the night."
      player.reset_stats
      player.restore
      puts "You wake up feeling rested. Time and sleep has healed all wounds."
    end

    def patron
      Game.new(player).patrons
      input = Input.new("Who would you like to speak to?\nThe [F]armers\nThe well-armed [M]an\nThe [B]oy", %[F M B]).get_char
      speak_to_patron(input)
    end

    def speak_to_patron(input)
      case input
      when "F"
        farmers
      when "M"
        man
      when "B"
        boy
      end
    end

    def farmers
      puts "yadda yadda yadda"
      # farmers quest
    end

    def man
      puts "yadda yadda yadda"
      # man quest
    end

    def boy
      puts "yadda yadda yadda"
      # boy quest
    end
  end
end
