# frozen_string_literal: true

# A class which represents an individual game board pin
class Peg
  attr_reader :symbol, :color

  COLORS = {
    red: 31,
    green: 32,
    brown: 33,
    blue: 34
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

# Helper module to generate rows of pegs ('codes')
module Rowable
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
    @code = create_row(:red, :red, :blue, :brown)
    @user_guesses = []
  end

  def play
    @user_guesses = create_row(:red, :red, :blue, :brown)
    result = calculate_matches_and_near_hits

    print @code.join(' ')
    puts ''
    print @user_guesses.join(' ')
    result[:black_pegs].times { print ResultPeg.new(:full_match) }
    result[:white_pegs].times { print ResultPeg.new(:partial_match) }
    puts ''
    play unless game_won?
  end

  def game_won?
    game_won = color_list(@code).eql?(color_list(@user_guesses))
    puts 'You won!  You are great.' if game_won
    game_won
  end

  def calculate_matches_and_near_hits
    black_pegs = 0
    white_pegs = 0
    computer_colors = color_list(@code)

    computer_colors.each_with_index do |color, index|
      user_color = color_list(@user_guesses)[index]
      if user_color == color
        black_pegs += 1
      elsif computer_colors.include?(user_color)
        white_pegs += 1
      end
    end
    { black_pegs: black_pegs, white_pegs: white_pegs }
  end
end

game = MastermindGame.new
game.play

# class Guess; end
# class Player; end
# class Codemaker; end

# A guess
# Consists of:
#   - peg color
#   - peg location
# Returns:
# "black" peg (.any?.correct_color? AND .any?.correct_location?)
# "white" peg (.any?.correct_color? AND .any?!.correct_location?)

# A game board
# Consists of:
#   - two sides, one for each player
#   - 12 rows, where each row has 4 possible entries

# A computer selected win condition
# Consists of:
# 1 row of colored pegs, where the color and position of each peg is important

# (Maybe) -- visual representation of the ongoing game
# 12 rows, where each row has a peg readout to its side
# Use a good character to represent the pegs...maybe a bullet? bullet = "\u2022"
# Check here when the time comes: https://compart.com/en/unicode/block/U+25A0
# Define possible peg colors? red, green, blue, gold (plus white & black for feedback)
# def colorize(color, string)
#   switch(color)
#     case 'red':
#       "\e[31m#{string}\e[0m"
#       break;
#     case 'green':
#       "\e[32m#{string}\e[0m"
#        break;
#     case 'brown':
#       "\e[33m#{string}\e[0m"
#       break;
#     case 'blue':
#       "\e[34m#{string}\e[0m"
#       break;
#   end
# end
# Alternatively, could use different symbols instead of colors...

# Game loop
# 12 total turns (12.times do...)
# player enters 5 guesses
# game evaluates 5 guesses
# for each guess:
#   - start with player's first peg
#   - look through each computer peg
#     - are any pegs: pegs.any? peg.correct_color? and peg.correct_location? (black peg)
#     - are any pegs: pegs.any? peg.correct_color? and !peg.correct_location? (white peg)
#  return a hash of { black_pegs: count, white_pegs: count }
# 31-35 feel like they could be their own object... or attached to the computer win condition stuff
# If black_pegs == 4 then win!
# If turns are exhausted then lose!
# Repeat loop until turns are exhausted or player wins

# Game Rules for the code pattern:
# No empty spaces in the code
# Duplicate colors are OK
# Example code:
# red, red, blue, blue
# Example guess:
# red, red, red, blue
# Example response:
# black peg (1 correct red), black peg (2nd correct red), black peg (1 correct blue)
