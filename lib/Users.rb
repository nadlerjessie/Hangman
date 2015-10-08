class Users
  attr_reader :name
  attr_accessor :wins, :losses, :lives

  def initialize(name)
    @name = name
    @lives = 6
    @wins = 0
    @losses = 0
  end

  def make_guess
    # console puts something here
    gets.chomp
  end

  def update_games_played (win_or_lose)
      #finish later
      if win_or_lose == 'win'
        wins += 1
      else
        losses += 1
      end
      "You have #{self.wins} wins and #{self.losses} losses."
  end
  # penalize user?

end
