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
      hp      = fields[2].to_i
      hit     = fields[3].to_i
      defense = fields[4].to_i
      Player.new(name, job, hp, hit, defense)
    end
  end
end
