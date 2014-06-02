class Code
  
  PEG_CHOICES = ["R", "G", "B", "Y", "O", "P"]

  def self.parse(colors)
    user_pegs = colors.split("")
    Code.new(user_pegs)
  end

  def self.random
    PEG_CHOICES.sample(4)
  end

  def initialize(pegs = Code.random)
    @pegs = pegs
  end

  def exact_matches(other_code)
    exact_matches = 0
    other_code.each do |color|
      exact_matches += 1 if other_code[color] == @pegs[color]
    end
    exact_matches
  end

  def near_matches(other_code)
    # return number of common colors - exact matches

    #find number of reds in @pegs, find number of reds in other_code, get the minimum; iterate thorugh for all colors

    colors_in_pegs = @pegs.color_counter
    colors_in_other = other_code.color_counter
    common_colors = 0

    colors_in_pegs.each_key |color|
      if other_code[color] != nil
        common_colors += [@pegs[color], other_code[color]].min
      end
    end

  common_colors - @pegs.exact_matches(other_code)
  end

  def color_counter(pegs)
    hash = Hash.new {|hash, key| hash[key] = 0}

    pegs.each do |peg|
      hash[peg] += 1
    end
    hash

  end


end



class Game
  turns = 10
  attr_accessor :guess

  def play
    @secret_code = Code.new
    # looping 10 times
    i = 0
    while i < 11 && won? == false
      puts "You have #{10-i} turns left"
      self.guess
      self.print
      self.won?
      i += 1
    end

    @secret_code.exact_matches(guess_code)
  end

  def guess
    puts "What is your guess?"
    @guess = gets.chomp
    @guess_code = Code.parse(@guess)
  end

  def print
    exact = @guess_code.exact_matches(@secret_code)
    near = @guess_code.near_matches(@secret_code)

    p "You have #{exact} number of exact matches and #{near} number of near matches."
  end

  def won?
    return true if @secret_code == @guess_code
  end

end
