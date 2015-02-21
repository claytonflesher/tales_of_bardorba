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
      Player.new(name, profession, hpmax.to_i, hit.to_i, defense.to_i, magic, feats, hp.to_i)
    end
  end
end
