require "io/console"

module TalesOfBardorba
  class Input
    def initialize(question, answers = nil)
      @question = question
      @answers  = answers
    end

    attr_reader :question, :answers

    def get_char
      print "#{question}  "
      response = $stdin.getch.upcase 
      puts response
      if answers.nil? || answers.include?(response)
        response
      else
        puts "Oops. I didn't understand your reponse."
        get_char
      end
    end

    def get_line
      print "#{question}  "
      response = gets.strip
      if answers.nil? || answers.include?(response)
        response
      else
        puts "Oops. I didn't understand your reponse."
        get_line
      end
    end
  end
end
