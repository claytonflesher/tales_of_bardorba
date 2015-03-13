require_relative "status_effect"

module TalesOfBardorba
  class DegenerateStatusEffect < StatusEffect
    def initialize
      super("degenerate")
    end

    def defense_modifier(target)
      -(target.defense - 5)
    end
  end
end
