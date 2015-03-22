require "io/console"

module TalesOfBardorba
  class Input
    def initialize(filename)
      @filename                     = filename
      @contents                     = Hash.new
    end

    attr_reader :filename, :contents

    def download(category)
      contents[category] = Array.new
      File.foreach(File.join(__dir__, "../../data/input/#{filename}_#{category}.txt")) do |f|
        contents[category] << f.strip
      end
      if category == :question
        statement(category)
      end
    end

    def statement(category)
      contents[category].each do |line|
        puts line
      end
    end

    def get_char
      download(:question)
      download(:answers)
      response = $stdin.getch.upcase 
      puts response
      if contents[:answers].any? { |answer| answer.split.include?(response) }
        response
      else
        puts "Oops. I didn't understand your reponse."
        get_char
      end
    end

    def get_line
      download(:question)
      download(:answers)
      response = gets.strip
      if contents[:answers].any? { |answer| answer.split.include?(response) || answer == "any" }
        response
      else
        puts "Oops. I didn't understand your reponse."
        get_line
      end
    end
  end
end
