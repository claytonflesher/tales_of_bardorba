module TalesOfBardorba
  class Table
    def initialize(file)
      @file = file
    end

    def load_numbers
      table = Array.new
      File.open(@file, "r") do |f|
        while (line = f.gets)
          table << line.to_i
        end
      end
      return table
    end

    def load_strings
      table = Array.new
      File.open(@file, "r") do |f|
        while (line = f.gets)
          table << line.strip
        end
      end
      return table
    end
  end
end
