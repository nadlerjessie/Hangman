require 'pry'

class Board
  config_path = File.expand_path("../../db/library.txt", __FILE__)
  DICTIONARY = File.open( config_path ).map do |line|
    line.strip
  end
  LETTERS = "abcdefghijklmnopqrstuvwxyz".upcase

  attr_accessor :revealed_letters, :secret_word, :guess
  attr_reader :user

  def initialize
    begin
      @secret_word = DICTIONARY.sample.upcase
    end while self.secret_word.length < 4
    @revealed_letters = "_" * self.secret_word.length
  end

  def user=(user)
    @user = user
    user.boards << self
  end

  def check_guess?(guess)
    @guess = guess.upcase
    @secret_word.include?(self.guess)
  end

  def reveal_letter
    self.secret_word.split('').each_with_index do |letter, index|
      self.revealed_letters[index] = self.guess if letter == self.guess
    end
    self.revealed_letters
  end

  def check_valid?(guess)
    LETTERS.include?(guess) && !self.incorrect.include?(guess) && !self.correct.include?(guess)
  end

  def incorrect
    @incorrect ||= []
  end

  def correct
    @correct ||= []
  end

  def store_incorrect
    self.incorrect << self.guess
  end
  
  def store_correct
    self.correct << self.guess
  end
end