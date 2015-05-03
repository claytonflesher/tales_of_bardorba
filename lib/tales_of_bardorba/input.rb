require "io/console"

module TalesOfBardorba
  class Input
    def initialize(filename, available = nil)
      @filename   = filename
      @available  = available
      @question   = nil
      @answers    = nil
    end

    attr_reader :filename, :available, :question, :answers
    private :filename, :available, :question, :answers

    def download_file
      lines     = File.readlines(File.join(__dir__, "../../data/input/#{filename}.txt"))
      @answers  = lines.pop.split
      @question = lines.join
      puts @question
    end

    def get_char
      download_file
      response = $stdin.getch.upcase 
      puts response
      if answers.include?(response)
        return response
      else
        puts "Oops. I didn't understand your reponse."
        get_char
      end
    end

    def get_line
      check_available_and_download_file
      response = gets.strip
      if answers.include?(response) || answers.include?("--any--")
        return response
      else
        puts "Oops. I didn't understand your reponse."
        get_line
      end
    end

    private

    def check_available_and_download_file
      if available != nil
        @answers = available
      else
        download_file
      end
    end
  end
end
