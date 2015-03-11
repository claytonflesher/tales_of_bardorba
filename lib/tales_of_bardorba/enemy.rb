module TalesOfBardorba
  class Enemy
    def initialize(name, hp, hit, defense)
      @hpmax            = hp
      @default_hit      = hit
      @default_defense  = defense
      @name             = name
      @hp               = @hpmax
      @hit              = @default_hit
      @defense          = @default_defense
      status_effects
    end

    attr_accessor :hp, :hit, :defense, :stunned_for, :blinded_for, :sleep, :sleep_marker, :poison, :afraid
    attr_reader :name

    def status_effects
      @stunned_for  = 0
      @blinded_for  = 0
      @sleep        = false 
      @sleep_marker = @hp
      @poison       = false
      @afraid       = false
    end
    
    def damage(player)
      rand(1..6) + (@hit - player.defense)
    end
    
    def dead?
      hp < 0
    end

    def reset_hit
      @hit = @default_hit
    end

    def reset_defense
      @defense = @default_defense
    end

    def asleep?
      @sleep == true
    end

    def poisoned?
      @poison == true
    end

    def afraid?
      @afraid == true
    end
  end
end
