require_relative '../lib/User.rb'
require_relative '../lib/Board.rb'
require_relative '../lib/concerns/graphic.rb'
require 'pry'

extend Graphic

def play(user)
  board = Board.new
  user.reset_lives
  puts "Hi #{user.name}! You start with #{user.lives} lives."
  while user.lives > 0 && board.secret_word != board.revealed_letters
    classic(user)
    puts "\n\n\n #{board.reveal_letter.split('').join(' ')}"
    puts "Incorrect Letters Guessed:\n#{board.incorrect.sort.join(' ')}"
    if user.lives != 1
      puts "You have #{user.lives} lives left."
    else 
      puts "You have #{user.lives} life left."
    end
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
    classic(user)
    puts "You lose! The word was: #{board.secret_word}.\nDo you want to play again? Please enter yes or no:"
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
  if game_over.downcase == 'no'
    goodbye
  elsif game_over.downcase == 'yes'
    puts "Would you like to create a new user?"
    input = gets.chomp
    if input == 'no'
      exit
    elsif input == 'yes'
      puts "Please enter a new name."
      new_name = gets.chomp
      user.initialize(new_name)
    else
      puts "That's not a valid command."
    end
  end
end

  def switch_users
    puts "The last #{user.all.count} players were: #{user.all.split}.\nWhich user were you?"
    input = gets.chomp
    if user.all.include?(input)
      puts "Welcome back, #{input}!"
      play(input)
    else
      puts "That name isn't in there!" redo
    end
  end

  # four commands - leaderboard
  # create a new user, switch users (list previous users, do by index number), see scoreboard, exit
  # new user
  # switch user

end
<<<<<<< HEAD
=======


>>>>>>> origin/master
