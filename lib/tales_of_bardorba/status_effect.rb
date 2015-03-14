module TalesOfBardorba
  class StatusEffect
    def initialize(name)
      @name = name
    end

    attr_reader :name

    def apply_before_turn(target)
      # do nothing:  subsclasses will override
    end

    def can_act?
     true
    end

    def hit_modifier(target)
      0
    end

    def defense_modifier(target)
      0
    end

    def apply_after_turn(target)
      # do nothing:  subsclasses will override
    end
  end
end
