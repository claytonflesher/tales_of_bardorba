module TalesOfBardorba
  class Job
    def initialize(job)
      @job  = job
    end

    attr_reader :job

    def hpmax
      case job
      when "squire"
        hpmax = 100
      when "streetrat"
        hpmax = 85
      when "magician"
        hpmax = 80
      end
      hpmax.to_i
    end

    def hit
      case job
      when "squire"
        hit = 20
      when "streetrat"
        hit = 15
      when "magician"
        hit = 10
      end
      hit.to_i
    end

    def defense
      case job
      when "squire"
        defense = 10
      when "streetrat"
        defense = 8
      when "magician"
        defense = 5
      end
      defense.to_i
    end

    def magic
      case job
      when "squire"
        magic = false
      when "streetrat"
        magic = false
      when "magician"
        magic = true
      end
    end

    def feats
      case job
      when "squire"
        feats = false
      when "streetrat"
        feats = true
      when "magician"
        feats = false
      end
      feats
    end
  end
end
