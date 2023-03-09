require_relative "game_turn"
require_relative "treasure_trove"

module StudioGame
  class Game
    attr_reader :title

    def initialize(title)
      @title = title
      @players = []
    end

    def load_players(file)
      File.readlines(file).each do |line|
        add_player(Player.from_csv(line))
      end
    end

    def add_player(player)
      @players << player
    end

    def total_points
      @players.map do |p|
        p.points
      end.sum
    end

    def play(rounds)
      puts "There are #{@players.size} players in #{@title}:"
      @players.each { |p| puts p }

      treasures = TreasureTrove::TREASURES
      puts "\nThere are #{treasures.size} treasures to be found:"
      treasures.each { |t| puts "A #{t.name} is worth #{t.points} points"}
    
      rounds.times do |r|
        if block_given?
          break if yield
        end

        puts "\nRound #{r+1}:"
        @players.each do |player|
          GameTurn.take_turn(player)
          puts player
        end
      end
    end

    def print_stats
      puts "\n#{@title} Statistics:"
      strong, weak = @players.partition { |p| p.strong? }

      puts "#{strong.size} strong players:"
      strong.each { |p| print_name_and_health(p) }

      puts "\n#{weak.size} wimpy players:"
      weak.each { |p| print_name_and_health(p) }

      puts "\n#{@title} High Scores:"
      @players.sort.each do |player|
        puts high_score_entry(player)
      end
      @players.sort.each do |p|
        puts "\n#{p.name}'s point totals:"
        p.each_found_treasure do |treasure|
          puts "#{treasure.points} total #{treasure.name} points"
        end
        puts "#{p.points} grand total points"
      end
    end

    def print_name_and_health(player)
      puts "#{player.name} (#{player.health})"
    end

    def high_score_entry(player)
      "#{player.name.ljust(20, ".")} #{player.score}"
    end

    def save_high_scores(filename="high_scores.txt")
      File.open(filename, "w") do |f|
        f.puts "#{@title} High Scores:"
        @players.sort.each do |p|
          f.puts high_score_entry(p)
        end
      end
    end
  end
end