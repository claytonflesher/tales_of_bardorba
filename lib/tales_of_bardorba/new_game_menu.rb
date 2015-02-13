require_relative "input"
require_relative "player"
require_relative "game"

module TalesOfBardorba
  class NewGameMenu
    def show
      name = Input.new("What would you like to name your character?").get_line
      Game.new(Player.new(name)).play
    end
  end
end
