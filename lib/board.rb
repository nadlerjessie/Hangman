class Board
  DICTIONARY = ['word']
  attr_reader :secret_word, :guess, :revealed_letters

  def initialize
    @secret_word = DICTIONARY.sample
    @revealed_letters = "_ " * self.secret_word.length
  end

  def check_guess?(guess)
    @guess = guess
    @secret_word.include?(self.guess)
  end

  def reveal_letter
    self.secret_word.split.each_with_index do |letter, index|
      self.revealed_letters[index] = self.guess if letter == self.guess
    end
    self.revealed_letters
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