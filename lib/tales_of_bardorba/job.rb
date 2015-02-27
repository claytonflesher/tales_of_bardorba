module TalesOfBardorba
  class Job
    FILENAME = File.join(__dir__, "../../data/jobstats.txt")

    def initialize(job)
      @job        = job
      @stats      = Hash.new
      @hpmax      = nil
      @hit        = nil
      @defense    = nil
      @magic      = false
      @feats      = false
      @hp         = nil
    end

    attr_reader :job, :stats
    attr_accessor :hpmax, :hit, :defense, :magic, :feats, :hp

    def load_file
      File.open(FILENAME, "r") do |f|
        while (line = f.gets) 
          if line.include?(job)
            5.times do
              item = f.gets.strip.split("=")
              @stats[item[0]] = item[1]
              p @stats
            end
          end
        end
      end
    end

    def set_stats
      load_file
      @hpmax    = @stats["hpmax"].to_i
      @hit      = @stats["hit"].to_i
      @defense  = @stats["defense"].to_i
      @magic    = @stats["magic"] == "true"
      @feats    = @stats["feats"] == "true"
      @hp       = @hpmax
    end

    def match_stats(stats)
      @hpmax    = stats["hpmax"]
      @hit      = stats["hit"]
      @defense  = stats["defense"]
      @magic    = stats["magic"]
      @feats    = stats["feats"]
      @hp       = stats["hp"]
    end
  end
end

