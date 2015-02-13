require_relative "saved_game"

module TalesOfBardorba
  class LoadGameMenu
    def show
      puts "Loading game..."
      player = SavedGame.new.load
      Game.new(player).play
    end
  end
end 
