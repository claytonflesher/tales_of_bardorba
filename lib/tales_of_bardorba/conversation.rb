require_relative "input"
require_relative "drunk_status_effect"

module TalesOfBardorba
  BARCOST = 10
  INNCOST = 100
  class Conversation
    def initialize(player)
      @player = player
    end

    attr_reader :player
    private :player
    
    def bartender
      puts "It'll cost you $#{BARCOST}."
      input = Input.new(:bartender).get_char
      if input == "Y"
        if player.money >= BARCOST
          get_drunk
        else
          puts "You don't have enough money."
        end
      end
    end

    def get_drunk
      puts "The bartender pours you an ale."
      puts "'That'll be $#{BARCOST}."
      player.lose_money(BARCOST)
      sleep 0.5
      puts "It hits the spot.\nYou feel a little tipsy."
      player.apply_status_effect(DrunkStatusEffect.new(10))
    end

    def innkeep
      puts "It'll cost you $#{INNCOST}."
      input = Input.new(:innkeep).get_char
      if input == "Y"
        if player.money >= INNCOST
          get_room
        else
          puts "You don't have enough money."
        end
      end
    end
    
    def get_room
      puts "You pay $#{INNCOST}."
      player.lose_money(INNCOST)
      puts "You sleep for the night."
      player.reset_stats
      player.restore
      puts "You wake up feeling rested. Time and sleep has healed all wounds."
    end

    def patron
      input = Input.new(:choose_patron).get_char
      speak_to_patron(input)
    end

    def farmers
      puts "yadda yadda yadda"
      # farmers quest
    end

    def man
      puts "yadda yadda yadda"
      # man quest
    end
    
    private
    
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
  end
end
