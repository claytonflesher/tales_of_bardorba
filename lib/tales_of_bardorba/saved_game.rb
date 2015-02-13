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
      hp      = fields[1].to_i
      hit     = fields[2].to_i
      defense = fields[3].to_i
      Player.new(name, hp, hit, defense)
    end
  end
end
