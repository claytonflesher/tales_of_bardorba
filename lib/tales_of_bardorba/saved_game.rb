module TalesOfBardorba
  class SavedGame
    FILENAME = File.join(__dir__, "../../data/saved_game.txt")

    def create(player)
      File.open(FILENAME, "w") do |f|
        f.puts player
      end
    end

    def load
      fields  = File.read(FILENAME).strip.split("|")
      name    = fields[0]
      job     = fields[1]
      hpmax   = fields[2]
      hp      = fields[3].to_i
      hit     = fields[4].to_i
      defense = fields[5].to_i
      magic   = fields[6]
      feats   = fields[7]
      Player.new(name, profession, hpmax, hp, hit, defense, magic, feats)
    end
  end
end
