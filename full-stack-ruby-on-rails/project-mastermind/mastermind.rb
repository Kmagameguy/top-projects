# frozen_string_literal: true

# A class which represents an individual game board pin
class Peg
  attr_reader :symbol, :color, :location

  COLORS = {
    red: 31,
    green: 32,
    brown: 33,
    blue: 34
  }.freeze

  def initialize(color, location)
    @symbol = "\u25CF"
    @color = COLORS[color]
    @location = location
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

# class Guess; end
# class Player; end
# class Codemaker; end
# class MastermindGame; end

print Peg.new(:red, 1)
print Peg.new(:green, 2)
print Peg.new(:brown, 3)
print Peg.new(:blue, 4)
print ResultPeg.new(:full_match)
print ResultPeg.new(:partial_match)
puts ''
# Mastermind Components

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
