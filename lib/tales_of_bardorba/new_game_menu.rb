require_relative "input"
require_relative "player"
require_relative "job"
require_relative "game"

module TalesOfBardorba
  class NewGameMenu
    def show
      name       = Input.new("What would you like to name your character?").get_line
      profession = Input.new("What class would you like #{name} to be?\nsquire\nstreetrat\nmagician\n?", %w[squire streetrat magician]).get_line
      Game.new(Player.new(name, profession, Job.new(profession).set_stats)).play
    end
  end
end
