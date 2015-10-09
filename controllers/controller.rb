require_relative '../lib/User.rb'
require_relative '../lib/Board.rb'
require_relative '../lib/concerns/graphic.rb'
require 'pry'

extend ::Graphic

# def run
#   puts "Welcome to Hangman! Please input your name."
#   user = User.new(gets.chomp)
#   begin
#     on = play(user)
#   end while on == "yes"
#   goodbye
# end

def run
  current_user = nil
  begin
    puts "\nHANGMAN"
    puts "Logged in as #{current_user.name}" if current_user
    puts "Menu:\n1-Play\n2-Create User\n3-Select User\n4-Leaderboard\n5-Exit"
    
    menu_input = gets.chomp.to_i
    while !(1..5).include?(menu_input)
      puts "Invalid input. Please input option 1-5."
      menu_input = gets.chomp.to_i
    end

    case menu_input
    when 1
      if current_user
        current_user.reset_lives
        play(current_user)
      else
        puts "*Please create a user."
      end
    when 2
      puts "Please input your name."
      current_user = User.new(gets.chomp)
    when 3
      User.all.count > 0 ? switch_users : puts("*No users to list. Please create a user.")
    when 4
      User.all.count > 0 ? display_leaderboard : puts("*Leaderboard is empty!")
    when 5
      goodbye
    end
  end while menu_input != 5
end

def play(user)
  # Initiates the Board
  board = Board.new
  user.boards << board

  puts "Hi #{user.name}! You start with #{user.lives} lives."
  
  begin
    fishtank(user)
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
  end while user.lives > 0 && board.secret_word != board.revealed_letters && game_over(user, board) == "yes"
  
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
    fishtank(user)
  end
    y_n = gets.chomp.downcase
end

def list_users
  User.all.each_with_index do |user, index|
    puts "#{index+1} - #{user.name}"
  end
end

def switch_users
  list_users

  begin
    puts "Please select user number."
    user_switch = gets.chomp.to_i-1
    switched_user = User.all[user_switch]
  end while user_switch >= User.all.count
end

def display_leaderboard
  puts "*** LEADERBOARD ***"
  User.leaderboard.each do |rankings|
    puts "#{rankings.name}: #{rankings.wins}-#{rankings.losses}"
  end
end

def goodbye
  puts "Thanks for playing. Goodbye!"
end

