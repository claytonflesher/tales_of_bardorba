require_relative "serializer"

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

    def load
      Serializer.new(self).load(FILENAME, job)
    end
  end

  def match_stats(stats)
    @stats = stats
  end
end
