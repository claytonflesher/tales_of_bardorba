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

    attr_reader :job, :hpmax, :hit, :defense, :magic, :feats

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
      @hpmax    = @fields[1]
      @hit      = @fields[2]
      @defense  = @fields[3]
      set_magic
      set_feats
      @hp       = @hpmax
      [@hpmax.to_i, @hit.to_i, @defense.to_i, @magic, @feats, @hp.to_i]
    end

    def set_magic
      magic = @fields[4]
      if magic == "true"
        @magic = true
      end
    end

    def set_feats
      feats = @fields[5]
      if feats == "true"
        @feats = true
      end
    end
  end
end

