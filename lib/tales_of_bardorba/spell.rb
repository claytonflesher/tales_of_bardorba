require_relative "poisoned_status_effect"
require_relative "blinded_status_effect"
require_relative "stunned_status_effect"
require_relative "afraid_status_effect"
require_relative "asleep_status_effect"
require_relative "shield_status_effect"
require_relative "degenerate_status_effect"
require_relative "sapped_status_effect"

module TalesOfBardorba
  class Spell
    def initialize(caster, opponent, spell_chosen)
      @caster       = caster
      @opponent     = opponent
      @spell_chosen = spell_chosen
    end

    attr_reader :caster, :opponent, :spell_chosen

    def resolve
      send(@spell_chosen.downcase)
    end

    def flash
      duration = rand(1..5)
      opponent.apply_status_effect(BlindedStatusEffect.new(duration))
      puts "#{caster.name} sends sparks from their finger tips at #{opponent.name}.\nThe #{opponent.name} is blinded for #{duration} turns."
    end
    
    def zap
      duration = rand(1..3)
      opponent.apply_status_effect(StunnedStatusEffect.new(duration))
      puts "#{caster.name} emits a jolt of electricity.\n#{opponent.name} is stunned for #{duration} turn(s)."
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
      opponent.take_damage(amount)
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
      opponent.apply_status_effect(SappedStatusEffect.new)
      puts "#{caster.name}'s spell drains a small amount of #{opponent.name}'s defenses."
      caster.use_encounter_spell
    end

    def lightning
      amount = rand(10..20)
      opponent.take_damage(amount)
      puts "#{caster.name} calls down a bolt from the heavens, striking #{opponent.name} for #{amount} damage."
      caster.use_encounter_spell
    end

    def blizzard
      amount = rand(15..25)
      opponent.take_damage(amount)
      duration = rand(2..5)
      opponent.apply_status_effect(StunnedStatusEffect.new(duration))
      puts "#{caster.name} summons a raging ice storm, doing #{amount} damage and stunning #{opponent.name} for #{duration} turns."
      caster.use_encounter_spell
    end

    def fireball
      amount = rand(20..30)
      opponent.take_damage(amount)
      opponent.apply_status_effect(PoisonedStatusEffect.new)
      puts "#{caster.name} hurls a fireball from the heavens, causing #{amount} impact damage and setting #{opponent.name} aflame."
      caster.use_encounter_spell
    end

    def blackhole
      amount = rand(35..40)
      opponent.take_damage(amount)
      duration = rand(3..7)
      opponent.apply_status_effect(StunnedStatusEffect.new(duration))
      puts "#{caster.name} forms a black hole in the location of #{opponent.name}, causing #{amount} damage and preventing actions for #{duration} turns."
      caster.use_encounter_spell
    end

    def conflagration
      amount = rand(40..50)
      opponent.take_damage(amount)
      duration = rand(3..7)
      opponent.apply_status_effect(StunnedStatusEffect.new(duration))
      opponent.apply_status_effect(PoisonedStatusEffect.new)
      opponent.apply_status_effect(DegenerateStatusEffect.new)
      opponent.apply_status_effect(AfraidStatusEffect.new)
      puts "#{caster.name} summons a hellish firestorm, doing #{amount} damage and stunning #{opponent.name} for #{duration} rounds.\n#{opponent.name}'s armor is damaged and set ablaze.\n#{opponent.name} becomes frightened."
      caster.use_encounter_spell
    end
  end
end
