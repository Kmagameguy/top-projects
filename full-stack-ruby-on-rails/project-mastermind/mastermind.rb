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
    @user_guesses = create_row(*pick_a_code)
    result = calculate_matches_and_near_hits

    print @code.join(' ')
    puts ''
    print @user_guesses.join(' ')
    result[:black_pegs].times { print ResultPeg.new(:full_match) }
    result[:white_pegs].times { print ResultPeg.new(:partial_match) }
    puts ''
    @rounds -= 1
    play unless game_over?
  end

  def pick_a_code
    code = []
    while code.length < 4
      puts "Pick a peg (#{Peg::COLORS.keys.join(', ')}).  #{4 - code.length} pegs left to pick."
      selection = gets.chomp.strip.to_sym
      if Peg::COLORS.key?(selection)
        code.push(selection)
      else
        puts 'Invalid selection, try again.'
      end
    end
    code
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

  def calculate_matches_and_near_hits
    black_pegs = 0
    white_pegs = 0

    computer_colors = color_list(@code)

    computer_colors.each_with_index do |color, index|
      user_color = color_list(@user_guesses)[index]
      black_pegs += 1 if user_color == color
    end

    unmatched_computer = computer_colors.select.with_index do |color, index|
      user_color = color_list(@user_guesses)[index]
      user_color != color
    end.uniq

    unmatched_user = color_list(@user_guesses).select.with_index do |color, index|
      color != computer_colors[index]
    end.uniq

    unmatched_computer.each do |color, index|
      white_pegs += 1 if unmatched_user.include?(color)
    end

    { black_pegs: black_pegs, white_pegs: white_pegs }
  end
end

game = MastermindGame.new
game.play
