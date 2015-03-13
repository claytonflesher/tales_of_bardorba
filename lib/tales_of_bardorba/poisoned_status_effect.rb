require_relative "status_effect"

module TalesOfBardorba
  class PoisenedStatusEffect < StatusEffect
    def initialize
      super("poisoned")
    end

    def apply_after_turn(target)
      target.hp -= target.hpmax / 10
    end
  end
end
