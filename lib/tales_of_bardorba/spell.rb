require_relative "input"
require_relative "poisoned_status_effect"
require_relative "blinded_status_effect"
require_relative "stunned_status_effect"
require_relative "afraid_status_effect"
require_relative "asleep_status_effect"
require_relative "shield_status_effect"
require_relative "degenerate_status_effect"
require_relative "sap_status_effect"

module TalesOfBardorba
  class Spell
    def initialize(caster, opponent, spell_chosen)
      @caster       = caster
      @opponent     = opponent
      @spell_chosen = spell_chosen
    end

    attr_reader :player, :enemy, :spell_chosen

    def resolve
      send(@spell_chosen.downcase)
    end

    def flash
      opponent.apply_status_effect(BlindedStatusEffect.new)
      puts "#{caster.name} sends sparks from their finger tips at #{opponent.name}.\nThe #{opponent.name} is temporarily blinded."
    end
    
    def zap
      duration = rand(1..3)
      opponent.apply_status_effect(StunnedStatusEffect.new(duration))
      puts "#{caster.name} emits a jolt of electricity.\n#{opponent.name} is stunned for #{opponent.stunned_for} turn(s)."
    end

    def cure
      caster.heal
      puts "Calling upon the blessings of a deity, a healing light shines upon #{caster.name}."
    end

    def poison
      if rand(2) == 0
        opponent.apply_status_effect(PoisonedStatusEffect.new)
        puts "#{opponent.name} is poisoned and is slowly losing health."
      else
        puts "#{opponent.name} does not become poisoned."
      end
    end

    def antidote
      caster.status_effects.each do |status_effect|
        if status_effect.is_a?(PoisonedStatusEffect)
          caster.remove_status_effect(status_effect)
        end
      end
      puts "#{caster.name} calls upon the favor of the gods to cure poisoning."
    end

    def oil_slick
      duration = rand(1..6)
      opponent.apply_status_effect(StunnedStatusEffect.new(duration))
      puts "#{caster.name} shoots a stream of black oil from their fingers, creating a large pool that trips up #{opponent.name}."
    end

    def frighten
      puts "#{caster.name}'s face distorts into a horrifying mask."
      if rand(4) == 0
        opponent.apply_status_effect(AfraidStatusEffect.new)
        puts "#{opponent.name} is frightened."
      else
        puts "#{opponent.name} resists the spell."
      end
    end

    def sleep
      puts "#{caster.name} begins a droning chant."
      if rand(3) == 0
        opponent.apply_status_effect(AsleepStatusEffect.new)
        puts "#{opponent.name} dozes off to sleep."
      else
        puts "#{opponent.name} resists your spell."
      end
    end

    def acid
      amount = rand(1..5)
      opponent.damage(amount)
      puts "#{caster.name} forms a green cloud over #{opponent.name} that rains steaming acid.\nThe acid causes #{amount} damage to #{opponent.name}"
      poison
    end

    def shield
      puts "#{caster.name} forms a magical barrier of protection, making them more difficult to hit."
      caster.apply_status_effect(ShieldStatusEffect.new)
    end

    def degenerate
      puts "You fire a blast that weakens your opponent's defenses."
      opponent.apply_status_effect(DegenerateStatusEffect.new)
    end

    def sap
      opponent.apply_status_effect(SapStatusEffect.new)
      caster.use_encounter_spell
      puts "#{caster.name}'s spell drains a small amount of #{opponent.name}'s defenses."
    end
  end
end
