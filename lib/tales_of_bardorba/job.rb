module TalesOfBardorba
  class Job
    FILENAME = File.join(__dir__, "../../data/jobstats.txt")

    def initialize(job)
      @job        = job
      @fields     = Array.new
      @hpmax      = nil
      @hit        = nil
      @defense    = nil
      @magic      = false
      @feats      = false
      @hp         = nil
    end

    attr_reader :job
    attr_accessor :hpmax, :hit, :defense, :magic, :feats, :hp

    def load_file
      File.open(FILENAME, "r") do |f|
        while (line = f.gets) 
          if line.include?(job)
            @fields = line.strip.split("|")
          end
        end
      end
    end

    def set_stats
      load_file
      @hpmax    = @fields[1].to_i
      @hit      = @fields[2].to_i
      @defense  = @fields[3].to_i
      @magic    = @magic == "true"
      @feats    = @feats == "true"
      @hp       = @hpmax
    end

    def match_stats(hpmax, hit, defense, magic, feats, hp)
      @hpmax    = hpmax
      @hit      = hit
      @defense  = defense
      @magic    = magic
      @feats    = feats
      @hp       = hp
    end
  end
end

