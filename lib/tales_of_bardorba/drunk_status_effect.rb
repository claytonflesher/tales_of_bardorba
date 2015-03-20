require_relative "status_effect_with_duration"

module TalesOfBardorba
  class DrunkStatusEffect < StatusEffectWithDuration
    def initialize(duration)
      super("drunk", duration)
    end
    
    def hit_modifier(target)
      -1
    end

    def defense_modifier(target)
      -3
    end
  end
end
