module TalesOfBardorba
  class Table
    def initialize(file)
      @file = file
    end

    def load_numbers
      load { |line| line.to_i }
    end

    def load_strings
      load { |line| line.strip }
    end

    def load
      table = Array.new
      File.open(@file, "r") do |f|
        while (line = f.gets)
          table << yield(line)
        end
      end
      return table
    end
  end
end
