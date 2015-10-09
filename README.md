#Synopsis
This is the working version of our Hangman application. Hangman is a CLI-based game in which a player tries to guess a word by inputting individual letters; if the letters are put in correctly, the user wins. If not, they die. Our particular rendition of it is a Ruby-based application with two classes (a User class, which defines the player’s actions, and a Board class, which defines game rules) and a terminal-based controller, where users play the actual game.
#Code Example
```ruby
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
```
#Motivation
This was our first class project for the Flatiron School web development course.
#Installation
You should be able to clone the repo and run it in a Unix terminal.
#Tests
Currently, Hangman only works with one user, but we’re currently in the middle of adding multi-user support – it’s just a basic app, though, so it shouldn’t make a huge difference one way or another!
#Contributors
Kjartan Angamaiton, Jessie Nadler, Heather Lim, Ho-Won Cheng
