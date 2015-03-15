require_relative "character"

module TalesOfBardorba
  class Enemy < Character
    def initialize(name, hp, hit, defense)
      @hpmax            = hp
      @default_hit      = hit
      @default_defense  = defense
      @name             = name
      @hp               = @hpmax
      @hit              = @default_hit
      @defense          = @default_defense
      @status_effects   = [ ]
    end

    attr_reader :name, :hp, :hit, :defense, :default_hit, :default_defense,
                :hpmax, :status_effects
  end
end
