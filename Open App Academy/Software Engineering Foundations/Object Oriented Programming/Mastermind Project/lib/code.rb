class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }
  attr_reader :pegs
  def self.valid_pegs?(charArr)
    charArr.each {|c| return false if !POSSIBLE_PEGS.has_key?(c.upcase)}
    return true
  end
  def initialize(pegs)
    if Code.valid_pegs?(pegs)
      @pegs = pegs.map {|c| c.upcase}
    else
      raise "The array does not contain valid pegs"
    end
  end
  def self.random(len)
    arr = []
    (0...len).each {|i| arr[i] = POSSIBLE_PEGS.keys.sample}
    return Code.new(arr)
  end
  def self.from_string(pegs)
    arr = []
    pegs.each_char.with_index {|char, i| arr[i] = char}
    return Code.new(arr)
  end
  def [](position)
    return @pegs[position]
  end
  def length
    return @pegs.length
  end
  def num_exact_matches(guess)
    pegs = guess.pegs
    count = 0
    @pegs.each_with_index {|color, ind| count += 1 if pegs[ind] == color}
    return count
  end
  def num_near_matches(guess)
    pegs = guess.pegs
    count = 0
    pegs.each_with_index do |color, ind| 
      count += 1 if @pegs[ind] != color && @pegs.include?(color)
    end
    return count
  end
  def ==(code)
    self.pegs == code.pegs
  end
end
