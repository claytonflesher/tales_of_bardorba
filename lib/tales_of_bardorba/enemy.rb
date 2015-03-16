require_relative "character"

module TalesOfBardorba
  class Enemy < Character
    def initialize(name, hp, hit, defense, money)
      super(name)
      @hpmax            = hp
      @default_hit      = hit
      @default_defense  = defense
      @money            = money
      @hp               = @hpmax
      @hit              = @default_hit
      @defense          = @default_defense
    end

    attr_reader :name, :hp, :hit, :defense, :default_hit, :default_defense,
                :hpmax, :status_effects, :money
  end
end
