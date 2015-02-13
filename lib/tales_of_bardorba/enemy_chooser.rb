require_relative "enemy"

module TalesOfBardorba
  class EnemyChooser
    def initialize
      @enemies = Array.new
      File.foreach(File.join(__dir__,"../../data/enemies.txt")) do |monster|
        fields  =  monster.split("|")
        name    = fields[0]
        hp      = fields[1].to_i
        hit     = fields[2].to_i  
        defense = fields[3].to_i  
        @enemies << Enemy.new(name, hp, hit, defense)
      end
    end

    def choose
      @enemies.sample
    end
  end
end


