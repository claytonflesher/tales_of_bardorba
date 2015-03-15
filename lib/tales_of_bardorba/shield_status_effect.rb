require_relative "status_effect"

module TalesOfBardorba
  class ShieldStatusEffect < StatusEffect
    def initialize
      super("shielded")
    end

    def defense_modifier(target)
      5
    end
  end
end
