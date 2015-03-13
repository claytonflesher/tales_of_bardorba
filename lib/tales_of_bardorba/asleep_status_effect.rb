require_relative "status_effect"

module TalesOfBardorba
  class AsleepStatusEffect < StatusEffect
    def initialize
      super("asleep")
      @hp_when_cast = nil
    end

    def can_act?
      false
    end

    def apply_before_turn(target)
      if @hp_when_cast
        if target.hp != @hp_when_cast
          target.remove_status_effect(self)
        end
      else
        @hp_when_cast = target.hp
      end
    end
  end
end
