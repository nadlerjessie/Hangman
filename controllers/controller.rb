require_relative '../lib/User.rb'
require_relative '../lib/Board.rb'
require 'pry'

def welcome
  puts "Welcome to Hangman! Please input your name."
  gets.chomp
end


board = Board.new

user = User.new(welcome)

while user.lives > 0 && board.secret_word != board.revealed_letters
  puts board.reveal_letter
  puts "Lives: #{user.lives}"
  puts "Please make a guess."
  current_guess = user.make_guess
  if board.check_valid?(current_guess)
    #binding.pry
    if board.check_guess?(current_guess)
      #binding.pry
      board.reveal_letter
      board.store_correct
    else
      board.store_incorrect
      user.lives -= 1
    end
  else
    puts "That's not a valid command."
  end
end
