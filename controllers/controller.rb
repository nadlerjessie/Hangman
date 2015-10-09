require_relative '../lib/User.rb'
require_relative '../lib/Board.rb'
require_relative '../lib/concerns/graphic.rb'

require 'pry'

extend ::Graphic

def play(user)
  board = Board.new
  user.reset_lives
  puts "Hi #{user.name}! You start with #{user.lives} lives."
  while user.lives > 0 && board.secret_word != board.revealed_letters
    classic(user)
    puts "\n\n\n #{board.reveal_letter.split('').join(' ')}"
    puts "Incorrect Letters Guessed:\n#{board.incorrect.sort.join(' ')}"
    puts "You have #{user.lives} lives left."
    puts "Please make a guess."
    current_guess = user.make_guess.upcase
    if board.check_valid?(current_guess)
      if board.check_guess?(current_guess)
        board.reveal_letter
        board.store_correct
      else
        board.store_incorrect
        user.lives -= 1
      end
    else
      puts "That's not a valid entry."
    end
  end

  game_over(user, board) 

end

def win?(board)
  board.secret_word == board.revealed_letters
end

def game_over(user, board)
  if win?(board)
    user.update_games_played("win")
    puts board.reveal_letter
    puts "You win! Do you want to play again? Please enter yes or no:"
  else
    user.update_games_played("lose")
    puts "You lose! The word was: #{board.secret_word}.\nDo you want to play again? Please enter yes or no:"
    classic(user)
  end
    y_n = gets.chomp.downcase
end

def goodbye
  puts "Thanks for playing. Goodbye!"
end

def run
  #board = Board.new
  puts "Welcome to Hangman! Please input your name."
  user = User.new(gets.chomp)
  begin
    on = play(user)
    # IF NOT YES ASK THEY WANT TO SWITCH USER, CREATE NEW USER, VIEW LEADERBOARD
    # OR EXIT
  end while on == "yes"
  goodbye
  # if game_over(user, board) == "yes"
  #   play
  # else
  #   goodbye
  # end      
end

def display_leaderboard(user)
  user.class.leaderboard.each do |rankings|
    puts "#{rankings.name}: #{rankings.wins}-#{rankings.losses}"
  end
end

def commands
  # three comands - leaderboard
  # new user
  # switch user

end

