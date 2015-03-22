require_relative "input"
require_relative "player"
require_relative "job"
require_relative "game"

module TalesOfBardorba
  class NewGameMenu
    def show
      name       = Input.new(:name).get_line
      profession = Input.new(:class).get_line
      job = Job.new(profession)
      job.load
      player = Player.new(name)
      player.assign_starting_stats(job)
      Game.new(player).play
    end
  end
end
