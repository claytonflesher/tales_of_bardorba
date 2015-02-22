module TalesOfBardorba
  class SavedGame
    FILENAME = File.join(__dir__, "../../data/saved_game.txt")

    def create(player)
      File.open(FILENAME, "w") do |f|
        f.puts player
      end
    end

    def load
      fields      = File.read(FILENAME).strip.split("|")
      name        = fields[0]
      profession  = fields[1]
      hpmax       = fields[2]
      hit         = fields[3]
      defense     = fields[4]
      magic       = fields[5]
      feats       = fields[6]
      hp          = fields[7]
      organize_stats(name, profession, hpmax, hit, defense, magic, feats, hp)
    end

    def organize_stats(name, profession, hpmax, hit, defense, magic, feats, hp)
      magic = set_magic(magic)
      feats = set_feats(feats)
      stats = [hpmax.to_i, hit.to_i, defense.to_i, magic, feats, hp.to_i]
      p stats
      Player.new(name, profession, stats)
    end

    def set_magic(magic)
      if magic == "true"
        magic = true
      else
        magic = false
      end
      return magic
    end

    def set_feats(feats)
      if feats == "true"
        feats = true
      else 
        feats = false
      end
      return feats
    end
  end
end
