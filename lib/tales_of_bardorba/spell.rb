require_relative "input"

module TalesOfBardorba
  class Spell
    def initialize(player, enemy, spell_chosen)
      @player       = player
      @enemy        = enemy
      @spell_chosen = spell_chosen
    end

    attr_reader :player, :enemy, :spell_chosen

    def resolve
      send(@spell_chosen.downcase)
    end

    def flash
      enemy.blinded_for = rand(1..3)
      enemy.hit = 1
      puts "You send sparks from your finger tips at #{enemy.name}.\nThe #{enemy.name} is temporarily blinded."
    end
    
    def zap
      enemy.stunned_for = rand(1..3)
      puts "You emit a jolt of electricity.\n#{enemy.name} is stunned for #{enemy.stunned_for} turn(s)."
    end

    def cure
      player.hp += (player.hpmax/4)
      if player.hp > player.hpmax
        player.hp = player.hpmax
      end
      puts "Calling upon the blessings of your deity, you feel a surge of healing power infuse you."
    end

    def poison
      bio = rand(2)
      if bio == 0
        enemy.poisoned = true
        puts "#{enemy.name} is poisoned and is slowly losing health."
      else
        puts "#{enemy.name} does not become poisoned."
      end
    end

    def antidote
      player.poisoned = false
      puts "#{player.name} calls upon the favor of the gods to cure poisoning."
    end

    def oil_slick
      enemy.stunned_for = rand(1..6)
      puts "You shoot a stream of black oil from your fingers, creating a large pool that trips up your opponent."
    end

    def frighten
      puts "Your face distorts into a horrifying mask."
      scare = rand(5)
      if scare == 0
        enemy.afraid = true
        puts "#{enemy.name} is frightened."
      else
        puts "#{enemy.name} resists your spell."
      end
    end

    def sleep
      puts "You begin a droning chant."
      doze_off = rand(3)
      if doze_off == 0
        enemy.sleep = true
        enemy.sleep_marker = enemy.hp
        puts "#{enemy.name} dozes off to sleep."
      else
        puts "#{enemy.name} resists your spell."
      end
    end

    def acid
      damage = rand(1..5)
      puts "You form a green cloud over #{enemy.name} that rains steaming acid.\nThe acid causes #{damage} damage to #{enemy.name}"
      poison
    end

    def shield
      puts "You form a magical barrier of protection, making you more difficult to hit."
      player.defense += 5
    end

    def degenerate
      puts "You fire a blast that weakens your opponent's defenses."
      enemy.defense -= 5
    end

    def sap
      enemy.defense -= 1
      player.encounter_spells -= 1
      puts "Your spell drains a small amount of #{enemy.name}'s defenses."
    end
  end
end
