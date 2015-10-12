require_relative '../lib/concerns/graphic.rb'

class UserController

  include ::Graphic

  def create_user
    puts "Please input your name."
    current_user = User.new(gets.chomp)
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
    switched_user
  end

  def display_leaderboard
    puts "\n*** LEADERBOARD ***"
    User.leaderboard.each do |rankings|
      puts "#{rankings.name}: #{rankings.wins}-#{rankings.losses}"
    end
  end

  def play(user)
    begin
      board = Board.new
      user.boards << board
      user.reset_lives
      puts "\nHi #{user.name}! You start with #{user.lives} lives."
      begin
        view = UserDisplay.new
        view.render(user)

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
      end while user.lives > 0 && board.secret_word != board.revealed_letters
    end while game_over(user) == "yes"
  end

  def win?(board)
    board.secret_word == board.revealed_letters
  end

  def game_over(user)
    if win?(user.boards[-1])
      user.update_games_played("win")
      view = UserWin.new
      view.render(user)
    else
      user.update_games_played("lose")
      view = UserLose.new()
      view.render(user)
    end
    begin
      puts "Please enter yes or no:"
      y_n = gets.chomp.downcase
    end while !(y_n == "yes" || y_n == "no")
    y_n
  end
end