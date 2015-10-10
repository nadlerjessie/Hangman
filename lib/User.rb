require 'pry'

class User
  attr_reader :name
  attr_accessor :wins, :losses, :lives

  def initialize(name)
    @name = name
    @lives = 6
    @wins = 0
    @losses = 0
    self.class.all << self
  end

  def self.all
    @@all ||= []
  end

  def make_guess
    gets.chomp
  end

  def points
    @points = (self.wins*3) - (self.losses)
  end

  def update_games_played (win_or_lose)
      if win_or_lose == 'win'
        self.wins += 1
      else
        self.losses += 1
      end
  end

  def reset_lives
    self.lives = 6
  end

  def self.leaderboard
    self.all.sort_by! do |user|
      user.points
    end.reverse
  end

  def boards
    @boards ||= []
  end
end
