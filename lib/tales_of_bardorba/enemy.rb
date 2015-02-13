module TalesOfBardorba
  class Enemy
    def initialize(name, hp, hit, defense)
      @name     = name
      @hp       = hp
      @hit      = hit
      @defense  = defense
    end

    attr_accessor :hp
    attr_reader :hit, :defense, :name
    
    def damage
      rand(1..6)
    end
    
    def dead?
      hp < 0
    end
  end
end
