module TalesOfBardorba
  class SavedGame
    FILENAME = File.join(__dir__, "../../data/saved_game.txt")

    def create(player)
      File.open(FILENAME, "w") do |f|
        f.puts player
      end
    end

    def load
      pull_player_data
      job = Job.new(@profession)
      job.match_stats(@hpmax, @hit, @defense, @magic, @feats, @hp) #I'm open to suggestions here.
      Player.new(@name, job)
    end

    def pull_player_data
      fields      = File.read(FILENAME).strip.split("|")
      @name        = fields[0]
      @profession  = fields[1]
      @hpmax       = fields[2].to_i
      @hit         = fields[3].to_i
      @defense     = fields[4].to_i
      @magic       = fields[5] == "true"
      @feats       = fields[6] == "true"
      @hp          = fields[7].to_i
    end
  end
end
