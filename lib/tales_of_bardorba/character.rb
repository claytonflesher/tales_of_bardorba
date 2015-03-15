module TalesOfBardorba
  class Character
    def initialize(name)
      @name           = name
      @status_effects = [ ]
    end

    def apply_status_effect(status_effect)
      status_effects << status_effect
    end

    def remove_status_effect(status_effect)
      status_effects.delete(status_effect)
    end

    def damage(opponent)
      rand(1..6) + (@hit - opponent.defense)
    end

    def take_damage(amount)
      @hp -= amount
    end

    def dead?
      @hp < 1
    end

    def reset_hit
      @hit = @default_hit
    end

    def reset_defense
      @defense = @default_defense
    end

    def heal
      @hp += @hpmax / 4
      if @hp > @hpmax
        @hp = @hpmax
      end
    end

    def restore
      @hp = @hpmax
    end
  end
end

