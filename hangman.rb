class Hangman
  attr_accessor :guessing_player, :checking_player

  def initialize (guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
  end

  def play
    h = checking_player.pick_secret_word
    while true
      # guessing_player.receive_secret_length(h)
      board =  checking_player.check_guess(guessing_player.guess)
      p board
      break unless board.include?("_")
    end
  end
end


class HumanPlayer

  def pick_secret_word
    puts "Choose a secret word."
    puts "How long is your word?"
    answer_length = Integer(gets.chomp)
    @board = Array.new(answer_length){"_"}
  end

  # def self.receive_secret_length(num)
  #   @board = Array.new(num){"_"}
  # end

  def guess
    puts "Pick a letter."
    guess = gets.chomp
    #validations/ already guessed?
  end

  def check_guess(guess)
    @guess = guess
    puts "Correct guess? (y/n)"
    check = gets.chomp
    if check == "y"
      puts "At which indices can I input the guessed letter?"
      string_of_indices = gets.chomp
      indices = string_of_indices.split("").map! {|a| a.to_i}
      handle_guess_response(indices)
    else
      @board
    end
  end

  def handle_guess_response(indices)
    @board.each_index do |index|
      @board[index] = @guess if indices.include?(index)
    end
    @board
  end

end




class ComputerPlayer

  def pick_secret_word
    contents = []
    File.readlines("dictionary.txt").each do |line|
      contents << line.chomp
    end
    @word = contents.sample
    @board = Array.new(@word.length){"_"}
    @word.length

  end

  def receive_secret_length(num)
    @board = Array.new(num){"_"}
  end

  def guess
    guess = rand(97..122).chr
    puts guess
    guess
  end

  def check_guess(guess)
    indices = []
    @word.split("").each_with_index do |letter, index|
      indices << index if letter == guess
    end
    handle_guess_response(indices)
  end

  def handle_guess_response(indices)
    @board.each_index do |index|
      @board[index] = @word[index] if indices.include?(index)
    end
    @board
  end

    # @board.each do |index|
    #   @board.join("").map! do |dash|
    #     if indexes.include?(index)
    #       dash.gsub!("_", @word[index]
    #     end
    #   end
    #
    #   @board
    # end

end

game1 = Hangman.new(ComputerPlayer.new, HumanPlayer.new)
game1.play
