require_relative "treasure_trove"
require_relative "playable"

module StudioGame
  class Player

    include Playable

    attr_reader :health
    attr_accessor :name

    def self.from_csv(csv)
      name, health = csv.split(",")
      Player.new(name, health.to_i)
    end

    def initialize(name, health=100)
      @name = name.capitalize
      @health = health
      @found_treasures = Hash.new(0)
    end

    def score
      @health + points
    end

    def to_s
      "I'm #{@name} with a health = #{@health}, points = #{points}, and score of #{score}."
    end

    def name=(name)
      @name = name.capitalize
    end

    def <=>(other)
      other.score <=> score
    end

    def found_treasure(treasure)
      @found_treasures[treasure.name] += treasure.points
      puts "#{@name} founda a #{treasure.name} worth #{treasure.points} points."
      puts "#{@name}'s treasures: #{@found_treasures}"
    end

    def points
      @found_treasures.values.sum
    end

    def each_found_treasure
      @found_treasures.each do |name, points|
        yield Treasure.new(name, points)
      end
    end
  end
end

if __FILE__ == $0
  player = Player.new("moe")
  puts player.name
  puts player.health
  player.w00t
  puts player.health
  player.blam
  puts player.health
end