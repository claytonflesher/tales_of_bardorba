module TalesOfBardorba
  class Player
    def initialize(hp = 100, hit = 10, defense = 2)
      @hp       = hp
      @hit      = hit
      @defense  = defense
    end
  
    attr_accessor :hp
    attr_reader :hit, :defense

    def name
      "Calvyn"
    end

    def damage
      rand(1..6)
    end

    def dead?
      hp < 0
    end
  end
end
