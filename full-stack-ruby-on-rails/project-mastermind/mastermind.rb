# frozen_string_literal: true

# A class which represents an individual game board pin
class Peg
  attr_reader :symbol, :color

  COLORS = {
    red: 31,
    green: 32,
    yellow: 33,
    blue: 34,
    purple: 35,
    cyan: 36
  }.freeze

  def initialize(color)
    @symbol = "\u25CF"
    @color = COLORS[color]
  end

  def to_s
    colorize
  end

  private

  def colorize
    "\e[#{color}m#{symbol}\e[0m"
  end
end

# A class which represents the correctness of a pin's color & location
class ResultPeg
  attr_reader :symbol

  SYMBOLS = {
    full_match: "\u25A0",
    partial_match: "\u25A1"
  }.freeze

  def initialize(symbol)
    @symbol = SYMBOLS[symbol]
  end

  def to_s
    symbol.to_s
  end
end

# Used to manage output to the screen (terminal)
class Display
  def initialize
    @saved_rows = []
  end

  def save_row(row)
    @saved_rows << row
    show_history
  end

  def clear
    system('clear')
    puts ''
  end

  private

  def show_history
    spacer = ' '
    @saved_rows.each_with_index do |row, index|
      spacer = '' if (index + 1) > 9
      print "#{index + 1}. #{spacer} #{row}"
      puts ''
    end
    puts ''
  end
end

# Helper module to generate rows of pegs ('codes')
class Row
  attr_accessor :results
  attr_reader :colors

  MAX_ROW_SIZE = 4

  def initialize(*colors)
    @colors = colors.empty? ? random_code : colors.map(&:to_sym)
    @results = []
  end

  def to_s
    string = ''
    @colors.each do |color|
      string += "#{Peg.new(color)} "
    end

    @results.each do |peg_type|
      string += "#{ResultPeg.new(peg_type)} "
    end

    string
  end

  private

  def random_code
    row = []
    4.times do
      row.push(Peg::COLORS.keys.sample)
    end
    row.map(&:to_sym)
  end
end

# A class which has knowledge about the player (role, valid movements, etc)
class Player
  def initialize(is_codemaker = false)
    @is_codemaker = is_codemaker
  end

  def codemaker?
    !!@is_codemaker
  end

  def pick_colors
    input = ''
    loop do
      puts 'Type a color sequence (separated by spaces).'
      puts "Color options are: (#{Peg::COLORS.keys.join(', ')})."
      input = gets.chomp.strip.split(' ')
      break unless invalid_input?(input)
    end
    input.map(&:to_sym)
  end

  private

  def invalid_input?(input)
    error = (input.any? { |color| !Peg::COLORS.keys.include?(color.to_sym) } ||
    input.length != Row::MAX_ROW_SIZE)
    puts 'Invalid selection.  Try again.' if error
    error
  end
end

# An elevated player class which controls an AI opponent
class Computer < Player
  def pick_colors
    row = []
    4.times do
      row.push(Peg::COLORS.keys.sample)
    end
    row.map(&:to_sym)
  end

  def guess
    puts 'Computer is thinking...'
    sleep 1
    pick_colors
  end
end

# Our main class which controls the game state
class MastermindGame
  MAX_ROUNDS = 12

  def initialize
    @rounds = MAX_ROUNDS
    @player = Player.new(choose_role)
    @computer = Computer.new(!@player.codemaker?)
    @code = @player.codemaker? ? Row.new(*@player.pick_colors) : Row.new(*@computer.pick_colors)
    @user_guesses = []
    @display = Display.new
    @display.clear
  end

  def play
    @user_guesses = @player.codemaker? ? Row.new(*@computer.guess) : Row.new(*@player.pick_colors)
    @user_guesses.results = calculate_matches_and_near_hits
    @display.clear

    print @code
    puts ''
    @display.save_row(@user_guesses)

    @rounds -= 1
    play unless game_over?
  end

  private

  def choose_role
    puts 'Would you like to play as the Codemaker (0) or Codebreaker (1)?'
    gets.chomp.to_i.zero?
  end

  def game_over?
    game_won? || game_lost?
  end

  def game_won?
    game_won = @code.colors.eql?(@user_guesses.colors)
    if game_won
      puts 'You won!  You are great.' unless @player.codemaker?
      puts 'You lose!  The computer cracked your code.' if @player.codemaker?
    end
    game_won
  end

  def game_lost?
    game_lost = @rounds <= 0
    if game_lost
      puts 'You lose!  Try again sometime.' unless @player.codemaker?
      puts "You win! The computer couldn't crack your code." if @player.codemaker?
    end
    game_lost
  end

  # This method is awful
  # I've never played mastermind so this is my interpretation of the rules:
  # 1. First, figure out how many black pegs we owe (aka exact matches)
  # Then, to figure out the white pegs we owe:
  # 1. Strip out those matches from the source & guess arrays
  # 2. Remove duplicates from source and guess arrays
  # 3. Increase white peg count if a guessed color exists in the remainder of the code array
  def calculate_matches_and_near_hits
    pegs = []
    computer_colors = @code.colors

    computer_colors.each_with_index do |color, index|
      user_color = @user_guesses.colors[index]
      pegs << :full_match if user_color == color
    end

    unmatched_computer = computer_colors.select.with_index do |color, index|
      user_color = @user_guesses.colors[index]
      user_color != color
    end.uniq

    unmatched_user = @user_guesses.colors.select.with_index do |color, index|
      color != computer_colors[index]
    end.uniq

    unmatched_computer.each do |color|
      pegs << :partial_match if unmatched_user.include?(color)
    end

    pegs
  end
end

game = MastermindGame.new
game.play
