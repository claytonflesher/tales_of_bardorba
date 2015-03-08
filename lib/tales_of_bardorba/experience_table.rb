module TalesOfBardorba
  class ExperienceTable
    FILENAME = File.join(__dir__, "../../data/experience.txt")

    def load
      table = Array.new
      File.open(FILENAME, "r") do |f|
        while (line = f.gets)
          table << line.to_i
        end
      end
      return table
    end
  end
end
