require_relative '../lib/User.rb'
require_relative '../lib/Board.rb'
require 'pry'

def play(user, board)
  while user.lives > 0 && board.secret_word != board.revealed_letters
    puts board.reveal_letter
    puts "Hi #{user.name}! You have #{user.lives} lives left."
    puts "Please make a guess."
    current_guess = user.make_guess
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
end

def win?(board)
  board.secret_word == board.revealed_letters
end

def game_over(user, board)
  if win?(board)
    user.update_games_played("win")
    puts board.reveal_letter
    puts "You win! Do you want to play again? Please enter yes or no:"
    y_n = gets.chomp
  else
    user.update_games_played("lose")
    puts "You lose! The word was: #{board.secret_word}. \nDo you want to play again? Please enter yes or no:"
    y_n = gets.chomp
  end
end

def goodbye
  puts "Thanks for playing. Goodbye!"
end

def run
  board = Board.new
  puts "Welcome to Hangman! Please input your name."
  user = User.new(gets.chomp)
  play(user, board)
  if game_over(user, board) == "yes"
    play
  else
    goodbye
  end      
end




