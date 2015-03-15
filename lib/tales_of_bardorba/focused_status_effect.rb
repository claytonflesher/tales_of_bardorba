require_relative "status_effect"

module TalesOfBardorba
  class FocusedStatusEffect < StatusEffect
    def initiative
      super("focused")
    end

    def hit_modifier(target)
      5
    end

    def defense_modifier(target)
      -1
    end
  end
end
