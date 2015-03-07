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
      p stats
      job = Job.new(stats["profession"])
      job.stats = stats
      job.assign_stats
      Player.new(stats["name"], job)
    end

    def pull_player_data
      stats = Hash.new
      File.open(FILENAME, "r") do |f|
        while (line = f.gets)
          data = line.strip.split("=")
          stats = format_stats(data, stats)
        end
      end
      return stats
    end
    
    def format_stats(data, stats)
      if data[1] =~ /[0-9]$/
        stats[data[0]] = data[1].to_i
      elsif data[1] =~ /(true|false)$/
        stats[data[0]] = data[1] == "true"
      else
        stats[data[0]] = data[1]
      end
      return stats
    end
  end
end
