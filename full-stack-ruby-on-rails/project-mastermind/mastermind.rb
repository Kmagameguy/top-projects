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
    clear
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

  def initialize(colors = nil)
    @colors = colors.nil? ? random_colors : colors.map(&:to_sym)
    @results = []
  end

  def to_s
    pegs = @colors.map { |color| Peg.new(color).to_s } +
           @results.map { |peg_type| ResultPeg.new(peg_type).to_s }
    pegs.join(' ')
  end

  private

  def random_colors
    (1..MAX_ROW_SIZE).each_with_object([]) do |_i, row|
      row.push(Peg::COLORS.keys.sample)
    end
  end
end

# A class which has knowledge about the player (role, valid movements, etc)
class Player
  def initialize(codemaker: false)
    @codemaker = codemaker
  end

  def codemaker?
    !!@codemaker
  end

  def pick_colors
    input = ''
    loop do
      puts 'Type a color sequence (separated by spaces).'
      puts "Color options are: (#{Peg::COLORS.keys.join(', ')})."
      input = gets.chomp.strip.split(' ')
      break unless invalid_input?(input)

      puts 'Invalid selection.  Try again.'
    end
    Row.new(input)
  end

  private

  def invalid_input?(input)
    (input.any? { |color| !Peg::COLORS.keys.include?(color.to_sym) } ||
      input.length != Row::MAX_ROW_SIZE)
  end
end

# An elevated player class which controls an AI opponent
class Computer < Player
  def pick_colors
    puts 'Computer is thinking...'
    sleep 1
    Row.new
  end
end

# Our main class which controls the game state
class MastermindGame
  MAX_ROUNDS = 12

  def initialize
    @rounds = MAX_ROUNDS
    @player = Player.new(codemaker: choose_role)
    @computer = Computer.new(codemaker: !@player.codemaker?)
    @codebreaker = @player.codemaker? ? @computer : @player
    @codemaker = @player.codemaker? ? @player : @computer
    @coded_message = @codemaker.pick_colors
    @user_guesses = []
    @display = Display.new
    @display.clear
  end

  def play
    @user_guesses = @codebreaker.pick_colors
    @user_guesses.results = calculate_matches_and_near_hits
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
    game_won = @coded_message.colors.eql?(@user_guesses.colors)
    if game_won
      puts 'You won!  You are great.' unless @player.codemaker?
      puts 'You lose!  The computer cracked your code.' if @player.codemaker?
    end
    game_won
  end

  def game_lost?
    game_lost = @rounds <= 0
    if game_lost
      if @computer.codemaker?
        puts 'You lose!  Try again sometime.'
        puts "Computer's code was: #{@coded_message}"
      else
        puts "You win! The computer couldn't crack your code."
      end
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
    count_matches.concat(count_near_hits)
  end

  def count_matches
    pegs = []

    @coded_message.colors.each_with_index do |color, index|
      user_color = @user_guesses.colors[index]
      pegs << :full_match if user_color == color
    end

    pegs
  end

  def count_near_hits
    pegs = []

    unique_unmatched_user_pegs.intersection(unique_unmatched_code_pegs).count.times do
      pegs << :partial_match
    end

    pegs
  end

  def unique_unmatched_code_pegs
    @coded_message.colors.select.with_index do |color, index|
      user_color = @user_guesses.colors[index]
      user_color != color
    end.uniq
  end

  def unique_unmatched_user_pegs
    @user_guesses.colors.select.with_index do |color, index|
      color != @coded_message.colors[index]
    end.uniq
  end
end

game = MastermindGame.new
game.play
