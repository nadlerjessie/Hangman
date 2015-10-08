class User
  attr_reader :name
  attr_accessor :wins, :losses, :lives

  def initialize(name)
    @name = name
    @lives = 6
    @wins = 0
    @losses = 0
  end

  def make_guess
    gets.chomp
  end

  def update_games_played (win_or_lose)
      if win_or_lose == 'win'
        wins += 1
      else
        losses += 1
      end
  end

  def reset_lives
    self.lives = 6
  end
end
