require_relative "status_effect"

module TalesOfBardorba
  class AfraidStatusEffect < StatusEffect
    def initialize
      super("afraid")
    end

    def afraid?
      true
    end
  end
end
