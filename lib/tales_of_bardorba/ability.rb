require_relative "combat"
require_relative "poisoned_status_effect"
require_relative "blinded_status_effect"
require_relative "stunned_status_effect"
require_relative "afraid_status_effect"
require_relative "asleep_status_effect"
require_relative "shield_status_effect"
require_relative "degenerate_status_effect"
require_relative "sapped_status_effect"
require_relative "raged_status_effect"
require_relative "guarded_status_effect"

module TalesOfBardorba
  class Ability
    def initialize(caster, opponent, ability_chosen)
      @caster         = caster
      @opponent       = opponent
      @ability_chosen = ability_chosen
    end

    attr_reader :caster, :opponent, :ability_chosen
    private :caster, :opponent, :ability_chosen

    def resolve
      send(@ability_chosen.downcase)
    end

    def sweep
      duration = rand(1..3)
      opponent.apply_status_effect(StunnedStatusEffect.new(duration))
      puts "#{caster.name} sweeps the leg.\n#{opponent.name} is stunned for #{duration} turn(s)."
    end

    def feint
      duration = 2
      opponent.apply_status_effect(StunnedStatusEffect.new(duration))
      puts "#{caster.name} feints to the left, causing #{opponent.name} to miss their next round."
    end

    def bandage
      caster.heal
      puts "#{caster.name} wraps bandages around their wounds, stopping the flow of blood and healing some damage."
    end

    def bloody
      opponent.apply_status_effect(PoisonedStatusEffect.new)
      puts "#{caster.name} punctures #{opponent.name}, causing slow bloodloss."
    end

    def sleep_strike
      puts "#{caster.name} strikes a pressure point on #{opponent.name}."
      if rand(3) == 0
        opponent.apply_status_effect(AsleepStatusEffect.new)
        puts "#{opponent.name} falls asleep."
      else
        puts "#{opponent.name} endures and remains awake."
      end
    end

    def kick
      puts "#{caster.name} attempts to kick #{opponent.name}"
      if rand(2) == 0
        amount = 10
        duration = rand(1..3)
        opponent.take_damage(amount)
        opponent.apply_status_effect(StunnedStatusEffect.new(duration))
        puts "#{caster.name} connects, doing #{amount} damage and stunning #{opponent.name} for #{duration} turns."
      else
        puts "#{caster.name} missed."
      end
    end

    def focus
      attacker.apply_status_effect(FocusedStatusEffect.new)
      puts "#{caster.name} focuses their inner strength, greatly increasing #{caster.name}'s accuracy but sacrificing a small amount of defense."
    end

    def cheer 
      attacker.apply_status_effect(CheeredStatusEffect.new)
      puts "#{caster.name} pumps up, raising their own accuracy and defense."
    end

    def flurry
      puts "#{caster.name} attacks wildly with weapons in both hands, striking twice in a single round."
      round = Combat.new(caster, opponent)
      round.attack(caster, opponent)
      round.attack(caster, opponent)
    end

    def bash
      puts "#{caster.name} bashes their opponent with the hilt of a weapon."
      Combat.new(caster, opponent).attack(caster, opponent)
      if rand(2) == 0
        duration = rand(1..2)
        puts "#{opponent.name} is stunned for #{duration} rounds."
        opponent.apply_status_effect(StunnedStatusEffect.new(duration))
      end
    end

    def parry
      puts "#{caster.name} parries an attack from #{opponent.name}, exposing their defenses."
      opponent.apply_status_effect(DegenerateStatusEffect.new)
      duration = rand(1..2)
      opponent.apply_status_effect(StunnedStatusEffect.new(duration))
    end

    def elbow
      puts "#{caster.name} elbows #{opponent.name} in the face."
      Combat.new(caster, opponent).attack(caster, opponent)
      if rand(10) == 0
        duration = 10
        puts "#{opponent.name}'s nose is broken and they can't see a thing."
        opponent.apply_status_effect(BlindedStatusEffect.new(duration))
      end
    end

    def crouch
      puts "#{caster.name} moves into a crouching posture, greatly increasing defense."
      caster.apply_status_effect(ShieldStatusEffect.new)
    end

    def scream
      puts "#{caster.name} lets out a frightful scream, raising their own stats and weakening #{opponent.name}."
      caster.apply_status_effect(CheeredStatusEffect.new)
      opponent.apply_status_effect(DegenerateStatusEffect.new)
      opponent.apply_status_effect(AfraidStatusEffect.new)
    end

    def quad
      puts "Using years of training to accelerate into a blur of blades and fury, #{caster.name} strikes four times."
      Combat.new(caster, opponent).attack(caster, opponent)
      Combat.new(caster, opponent).attack(caster, opponent)
      Combat.new(caster, opponent).attack(caster, opponent)
      Combat.new(caster, opponent).attack(caster, opponent)
    end

    def palm
      amount = 5
      puts "#{caster.name} uses training to make an unerring palm attack that does #{amount} damage."
      opponent.take_damage(amount)
      caster.use_encounter_ability
    end

    def rage
      puts "#{caster.name} goes into a berserker rage, increasing damage by a massive amount."
      caster.status_effects.each do |status_effect|
        if status_effect.is_a?(GuardedStatusEffect)
          caster.remove_status_effect(status_effect)
        end
      end
      caster.apply_status_effect(RagedStatusEffect.new)
      caster.use_encounter_ability
    end

    def guard
      puts "#{caster.name} suddenly becomes calm, increasing defensive reflexies by a massive amount."
      caster.status_effects.each do |status_effect|
        if status_effect.is_a?(RagedStatusEffect)
          caster.remove_status_effect(status_effect)
        end
      end
      caster.apply_status_effect(GuardedStatusEffect.new)
      caster.use_encounter_ability
    end

    def cleave
      puts "#{caster.name} attempts to split #{opponent.name} in twain."
      if rand(5) == 0
        amount = rand(25..75)
        "#{caster.name} connects with a devastating blow, doing #{amount} damage."
      else
        Combat.new(caster, opponent).attack(caster, opponent)
      end
      caster.use_encounter_ability
    end

    def deathblow
      puts "In a desperate effort, #{caster.name} attempts to use a the mysterious Touch of Death."
      if rand(100) == 0
        puts "It connects!"
        opponent.take_damage(1000000000)
      else
        puts "It fails to connect."
      end
      caster.use_encounter_ability
    end
  end
end
