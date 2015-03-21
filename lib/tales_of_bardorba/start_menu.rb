require_relative "input"
require_relative "new_game_menu"
require_relative "load_game_menu"

module TalesOfBardorba
  class StartMenu
    def show
      puts "Welcome to Tales of Bardorba..."
      puts "    ...where you face Your Worst Nightmare."
      response = Input.new(:start_menu).get_char
      case response
      when "N"
        NewGameMenu.new.show
      when "L"
        LoadGameMenu.new.show
      end
    end
  end
end
