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
    " #{symbol}"
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
      print "#{index + 1}. #{spacer} #{row.join(' ')}"
      puts ''
    end
    puts ''
  end
end

# Helper module to generate rows of pegs ('codes')
module Rowable
  MAX_ROW_SIZE = 4

  def create_row(*colors)
    colors.empty? ? random_code : submit_code(colors)
  end

  def color_list(colors)
    colors.map(&:color)
  end

  private

  def submit_code(colors)
    row = []
    colors.each do |color|
      row.push(Peg.new(color))
    end
    row
  end

  def random_code
    row = []
    4.times do
      row.push(Peg.new(Peg::COLORS.keys.sample))
    end
    row
  end
end

# Our main class which controls the game state
class MastermindGame
  include Rowable

  MAX_ROUNDS = 12

  def initialize
    @rounds = MAX_ROUNDS
    @code = create_row(:red, :red, :blue, :cyan)
    @user_guesses = []
    @display = Display.new
    @display.clear
  end

  def play
    @user_guesses = create_row(*pick_a_code)
    result = calculate_matches_and_near_hits
    @display.clear

    print @code.join(' ')
    puts ''
    @display.save_row(@user_guesses + result)

    @rounds -= 1
    play unless game_over?
  end

  def pick_a_code
    input = ''
    loop do
      puts "Type a color sequence (separated by spaces). #{@rounds} rounds left."
      puts "Color options are: (#{Peg::COLORS.keys.join(', ')})."
      input = gets.chomp.strip.split(' ')
      break unless invalid_input(input)
    end

    input.map(&:to_sym)
  end

  def game_over?
    game_won? || game_lost?
  end

  def game_won?
    game_won = color_list(@code).eql?(color_list(@user_guesses))
    puts 'You won!  You are great.' if game_won
    game_won
  end

  def game_lost?
    game_lost = @rounds <= 0
    puts 'You lose!  Try again sometime.' if game_lost
    game_lost
  end

  def invalid_input(input)
    error = (input.any? { |color| !Peg::COLORS.keys.include?(color.to_sym) } ||
             input.length != MAX_ROW_SIZE)
    puts 'Invalid selection.  Try again.' if error
    error
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
    computer_colors = color_list(@code)

    computer_colors.each_with_index do |color, index|
      user_color = color_list(@user_guesses)[index]
      pegs << ResultPeg.new(:full_match) if user_color == color
    end

    unmatched_computer = computer_colors.select.with_index do |color, index|
      user_color = color_list(@user_guesses)[index]
      user_color != color
    end.uniq

    unmatched_user = color_list(@user_guesses).select.with_index do |color, index|
      color != computer_colors[index]
    end.uniq

    unmatched_computer.each do |color|
      pegs << ResultPeg.new(:partial_match) if unmatched_user.include?(color)
    end

    pegs
  end
end

game = MastermindGame.new
game.play
