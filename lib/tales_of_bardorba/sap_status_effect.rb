require_relative "status_effect"

module TalesOfBardorba
  class SapStatusEffect < StatusEffect
    def initialize
      super("sap")
    end

    def defense_modifier(target)
      -(target.defense - 1)
    end
  end
end
