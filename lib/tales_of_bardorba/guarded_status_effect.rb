require_relative "status_effect"

module TalesOfBardorba
  class GuardedStatusEffect < StatusEffect
    def initiative
      super("guarded")
    end

    def defense_modifier(target)
      15
    end
  end
end
