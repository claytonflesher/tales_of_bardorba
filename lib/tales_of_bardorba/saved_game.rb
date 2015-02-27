module TalesOfBardorba
  class SavedGame
    FILENAME = File.join(__dir__, "../../data/saved_game.txt")

    def create(player)
      File.open(FILENAME, "w") do |f|
        player.stats.each do |name, value|
          f.puts "#{name}=#{value}"
        end
      end
    end

    def load
      stats = pull_player_data
      job = Job.new(@profession)
      job.match_stats(stats)
      Player.new(@name, job)
    end

    def pull_player_data
      stats = Hash.new
      File.open(FILENAME, "r") do |f|
        while (line = f.gets)
          data = line.strip.split("=")
          stats[data[0]] = data[1]
        end
      end
      format_stats(stats)
    end
    
    def format_stats(stats)
      stats["hpmax"] = stats["hpmax"].to_i
      stats["hit"] = stats["hit"].to_i
      stats["defense"] = stats["defense"].to_i
      stats["magic"] = stats["magic"] == "true"
      stats["feats"] = stats["feats"] == "true"
      stats["hp"] = stats["hp"].to_i
      return stats
    end
  end
end
