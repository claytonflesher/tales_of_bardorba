require_relative "status_effect"

module TalesOfBardorba
  class CheeredStatusEffect < StatusEffect
    def initiative
      super("cheered")
    end

    def hit_modifier(target)
      5
    end

    def defense_modifier(target)
      5
    end
  end
end
