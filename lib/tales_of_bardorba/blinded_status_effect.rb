require_relative "status_effect_with_duration"

module TalesOfBardorba
  class BlindedStatusEffect < StatusEffectWithDuration
    def initialize(duration)
      super("blinded", duration)
    end

    def hit_modifier(target)
      -(target.hit - 1)
    end
  end
end
