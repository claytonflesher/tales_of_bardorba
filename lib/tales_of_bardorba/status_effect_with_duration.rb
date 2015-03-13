require_relative "status_effect"

module TalesOfBardorba
  class StatusEffectWithDuration < StatusEffect
    def initialize(name, duration)
      super(name)

      @duration = duration
    end

    def apply_after_turn(target)
      @duration -= 1
      if @duration <= 0
        target.remove_status_effect(self)
      end
    end
  end
end
