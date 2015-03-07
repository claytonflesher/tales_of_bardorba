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

    attr_reader :job
    attr_accessor :hpmax, :hit, :defense, :magic, :feats, :hp, :stats

    def load_file
      File.open(FILENAME, "r") do |f|
        while (line = f.gets) 
          if line.include?(job)
            6.times do
              data = f.gets.strip.split("=")
              format_stats(data)
            end
          end
        end
      end
    end

    def format_stats(data)
      if data[1] =~ /[0-9]$/
        @stats[data[0]] = data[1].to_i
      elsif
        data[1] =~ /(true|false)$/
        @stats[data[0]] = data[1] == "true"
      else
        @stats[data[0]] = data[1]
      end
    end

    def assign_stats
      @hpmax    = @stats["hpmax"]
      @hit      = @stats["hit"]
      @defense  = @stats["defense"]
      @magic    = @stats["magic"]
      @feats    = @stats["feats"]
      @hp       = @stats["hp"]
    end
  end

  def match_stats(stats)
    @stats = stats
  end
end

