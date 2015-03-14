require_relative "status_effect"

module TalesOfBardorba
  class SappedStatusEffect < StatusEffect
    def initialize
      super("sapped")
    end

    def defense_modifier(target)
      -(target.defense - 1)
    end
  end
end
