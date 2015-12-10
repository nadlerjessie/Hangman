class UserWin
  def render(user)
    puts user.boards[-1].reveal_letter
    puts "You win! Do you want to play again?"
  end
end