require_relative "player"
require_relative "enemy_chooser"
require_relative "combat"

module TalesOfBardorba
  class Game
    def initialize
    end

    def play
      Combat.new(Player.new, EnemyChooser.new.choose).resolve
    end
  end
end

