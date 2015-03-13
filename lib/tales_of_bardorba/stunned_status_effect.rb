require_relative "status_effect_with_duration"

module TalesOfBardorba
  class StunnedStatusEffect < StatusEffectWithDuration
    def initialize(duration)
      super("stunned", duration)
    end

    def can_act?
      false
    end
  end
end
