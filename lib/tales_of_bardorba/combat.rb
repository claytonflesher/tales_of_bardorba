require "io/console"

module TalesOfBardorba
  class Combat
    def initialize(player, enemy)
      @player = player
      @enemy  = enemy
    end

    attr_reader :player, :enemy

    def round
      response = get_player_action
      [player, enemy].shuffle.each do |actor|
        if actor == player && !player.dead?
          perform_player_action(response)
        elsif actor == enemy && !enemy.dead?
          swing(enemy, player)
        end
      end
      puts "#{player.name}'s current hp is #{player.hp}"
      puts
    end

    def get_player_action
      print "A for attack?  "
      response = $stdin.getch.upcase 
      puts response
      response
    end

    def perform_player_action(action)
      case action
      when "A"
        swing(player, enemy)
      else
        puts "Oops, I didn't understand that."
        perform_player_action
      end
    end

    def swing(attacker, target)
      if hit?(attacker, target)
        damage = attacker.damage
        target.hp -= damage
        puts "#{attacker.name} hit #{target.name} for #{damage} hp."
      else
        puts "#{attacker.name} missed #{target.name}."
      end
    end

    def hit?(attacker, target)
      attack = rand(1..(attacker.hit - target.defense))
      attack > 3
    end

    def resolve
      until player.dead? || enemy.dead?
        round
      end
      if player.dead?
        puts "#{player.name} died."
      else
        puts "Congrats, you vanquished #{enemy.name}."
      end
    end
  end
end
