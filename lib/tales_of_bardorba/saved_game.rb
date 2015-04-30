require_relative "player"
require "yaml"

module TalesOfBardorba
  class SavedGame
    FILENAME = File.join(__dir__, "../../data/saved_game.txt")

    def create(player)
      File.open(FILENAME, "w") { |f| f.write YAML.dump(player) }
    end

    def load
      player = YAML.load(File.read(FILENAME))
      player.reset_stats
      player
    end
  end
end
