class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  def self.random_word
    return DICTIONARY.sample
  end
  def initialize()
    @secret_word = Hangman.random_word
    @guess_word = []
    (0...@secret_word.length).each {|n| @guess_word[n] = "_"}
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end
  def guess_word
    return @guess_word
  end
  def attempted_chars
    return @attempted_chars
  end
  def remaining_incorrect_guesses
    return @remaining_incorrect_guesses
  end
  def already_attempted?(char)
    return @attempted_chars.include?(char)
  end
  def get_matching_indices(char)
    arr = []
    if @secret_word.include?(char)
      @secret_word.each_char.with_index { |c, i| arr << i if c == char }
    end
    return arr
  end
  def fill_indices(char, arr)
    arr.each { |i| @guess_word[i] = char}
  end
  def try_guess(char)
    attempt = already_attempted?(char)
    index = get_matching_indices(char)
    fill = fill_indices(char, index)
    if attempt
      p "that has already been attempted"
      return false
    elsif index.empty?
      @attempted_chars << char
      @remaining_incorrect_guesses -= 1
      return true
    else
      @attempted_chars << char
      return true
    end
  end
  def ask_user_for_guess
    p "Enter a char: "
    input = gets.chomp
    return try_guess(input)
  end
  def win?
    if (@guess_word.join("")) == @secret_word
      p "WIN"
      return true
    else
      return false
    end
  end
  def lose?
    if @remaining_incorrect_guesses == 0
      p "LOSE"
      return true
    else
      return false
    end
  end
  def game_over?
    if win? || lose?
      p @secret_word
      return true
    else
      return false
    end
  end
end