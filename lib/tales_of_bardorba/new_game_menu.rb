require_relative "input"
require_relative "player"
require_relative "job"
require_relative "game"

module TalesOfBardorba
  class NewGameMenu
    def show
      name       = Input.new("What would you like to name your character?").get_line
      profession = Input.new("What class would you like #{name} to be?\nsquire\nstreetrat\nmagician\n?", %w[squire streetrat magician]).get_line
      job = Job.new(profession)
      puts job.hpmax
      Game.new(Player.new(name, profession, job.hpmax.to_i, job.hit.to_i, job.defense.to_i, job.magic, job.feats)).play
    end
  end
end
