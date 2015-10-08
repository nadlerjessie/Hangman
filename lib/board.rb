require 'pry'

class Board
  DICTIONARY = ['word']
  LETTERS = "abcdefghijklmnopqrstuvwxyz"

  attr_reader :secret_word, :guess
  attr_accessor :revealed_letters

  def initialize
    @secret_word = DICTIONARY.sample
    @revealed_letters = "_" * self.secret_word.length
  end

  def check_guess?(guess)
    @guess = guess
    @secret_word.include?(self.guess)
  end

  def reveal_letter
    self.secret_word.split('').each_with_index do |letter, index|
      #binding.pry
      if letter == self.guess
        #binding.pry
        self.revealed_letters[index] = self.guess 
      end
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