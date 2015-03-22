require "io/console"

module TalesOfBardorba
  class Input
    def initialize(filename)
      @filename = filename
      @contents = Hash.new
    end

    attr_reader :filename, :contents

    def upload(filename)
      File.open(__dir__, "../../data/input/#{filename}.txt", "r") do |f|
        while (line = f.gets)
          contents[:question] = line.strip
          contents[:available_answers] = line[1].strip
          puts contents
        end
      end
    end

    def get_char
      upload(filename)
      print "#{contents[:question]}  "
      response = $stdin.getch.upcase 
      puts response
      if contents[:available_answers].nil? || contents[:available_answers].include?(response)
        response
      else
        puts "Oops. I didn't understand your reponse."
        get_char
      end
    end

    def get_line
      upload(filename)
      print "#{contents[:question]}  "
      response = gets.strip
      if contents[:available_answers].nil? || contents[:available_answers].include?(response)
        response
      else
        puts "Oops. I didn't understand your reponse."
        get_line
      end
    end
  end
end
