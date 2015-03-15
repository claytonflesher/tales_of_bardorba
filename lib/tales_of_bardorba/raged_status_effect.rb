require_relative "status_effect"

module TalesOfBardorba
  class RagedStatusEffect < StatusEffect
    def initiative
      super("raged")
    end

    def hit_modifier(target)
      10
    end
  end
end
