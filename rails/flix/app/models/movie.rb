class Movie < ApplicationRecord
  def flop?
    self.total_gross < 225000000
  end

  def self.released
    Movie.where("released_on < ?", Time.now.utc).order(released_on: :desc)
  end
end
