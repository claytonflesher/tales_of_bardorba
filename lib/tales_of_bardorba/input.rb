require "io/console"

module TalesOfBardorba
  class Input
    def initialize(filename, available = nil)
      @filename  = filename
      @available = available
      @contents  = Hash.new
    end

    attr_reader :filename, :available, :contents

    def download_file
      data = Array.new
      File.foreach(File.join(__dir__, "../../data/input/#{filename}.txt")) do |f|
        data << f.strip
      end
      @contents[:question] = data[0..-2]
      @contents[:answers]  = data[-1].split
      ask_question
    end

    def ask_question
      contents[:question].each do |line|
        puts line
      end
    end

    def get_char
      download_file
      response = $stdin.getch.upcase 
      puts response
      if contents[:answers].include?(response)
        return response
      else
        puts "Oops. I didn't understand your reponse."
        get_char
      end
    end

    def get_line
      check_available_and_download_file
      response = gets.strip
      if contents[:answers].include?(response) || contents[:answers].include?("--any--")
        return response
      else
        puts "Oops. I didn't understand your reponse."
        get_line
      end
    end

    def check_available_and_download_file
      if available != nil
        contents[:answers] = available
      else
        download_file
      end
    end
  end
end
