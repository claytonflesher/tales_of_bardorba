module TalesOfBardorba
  class Enemy
    def initialize(name, hp, hit, defense)
      @name         = name
      @hp           = hp
      @hit          = hit
      @defense      = defense
      @stunned_for  = 0
    end

    attr_accessor :hp, :defense, :stunned_for
    attr_reader :hit, :name
    
    def damage(player)
      rand(1..6) + (@hit - player.defense)
    end
    
    def dead?
      hp < 0
    end
  end
end
