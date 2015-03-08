require_relative "serializer"

module TalesOfBardorba
  class Job
    FILENAME = File.join(__dir__, "../../data/jobstats.txt")

    def initialize(name)
      @name       = name
      @stats      = Hash.new
      @hpmax      = nil
      @hit        = nil
      @defense    = nil
      @magic      = false
      @feats      = false
      @hp         = nil
    end

    attr_reader :name, :hpmax, :hit, :defense, :magic, :feats, :hp, :stats

    def load
      Serializer.new(self).load(FILENAME, name)
    end
  end
end
