require_relative "serializer"
require_relative "player"

module TalesOfBardorba
  class SavedGame
    FILENAME = File.join(__dir__, "../../data/saved_game.txt")

    def create(player)
      Serializer.new(player).save(FILENAME)
    end

    def load
      player = Player.new
      Serializer.new(player).load(FILENAME)
      player
    end
  end
end
