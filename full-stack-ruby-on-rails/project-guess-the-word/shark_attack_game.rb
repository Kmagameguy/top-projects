# frozen_string_literal: true

require './lib/wordable'
require './lib/displayable'
require './lib/game_file'

# A class to manage our game's state
class SharkAttackGame
  include Wordable
  include Displayable

  def initialize
    @correct_guesses = []
    @incorrect_guesses = []
    @shark_position = 0
    @word_to_guess = setup_game
    @saved_and_quit = false
    @input = ''
    draw_round(@word_to_guess, @correct_guesses, @incorrect_guesses)
  end

  def play
    ask_for_player_input
    return if @saved_and_quit

    show_round_results
    game_over? ? draw_game_over(@word_to_guess, won: game_won?) : play
  end

  private

  def setup_game
    load_game? ? load : pick_word
  end

  def ask_for_player_input
    puts 'Guess a letter or type "quit game" to quit:'
    @input = gets.chomp.to_s.downcase.strip

    if quit_game?
      quit
    elsif invalid_input?
      puts 'Invalid option.  Try again.'
      ask_for_player_input
    else
      record_input
    end
  end

  def load_game?
    return false unless GameFile.save_exists?

    puts 'Load saved game? (y/n)'
    yes_response?
  end

  def load
    data = GameFile.load
    @correct_guesses = data[:correct_guesses]
    @incorrect_guesses = data[:incorrect_guesses]
    @shark_position = data[:shark_position]
    @word_to_guess = data[:word_to_guess]
  end

  def save_game?
    puts 'Save before quiting? (y/n)'
    yes_response?
  end

  def quit_game?
    @input == 'quit game'
  end

  def quit
    @saved_and_quit = true
    save if save_game?
  end

  def save
    data = {
      correct_guesses: @correct_guesses,
      incorrect_guesses: @incorrect_guesses,
      shark_position: @shark_position,
      word_to_guess: @word_to_guess
    }

    GameFile.new(data)
  end

  def game_over?
    game_won? || game_lost?
  end

  def game_won?
    @correct_guesses.length == @word_to_guess.chars.uniq.length
  end

  def game_lost?
    @shark_position >= WAVE_COUNT
  end

  def invalid_input?
    (@input.length > 1 ||
      @correct_guesses.include?(@input) ||
      @incorrect_guesses.include?(@input) ||
      @input =~ /[^a-z]/)
  end

  def record_input
    @word_to_guess.chars.include?(@input) ? @correct_guesses << @input : @incorrect_guesses << @input
  end

  def show_round_results
    @shark_position = @incorrect_guesses.size
    draw_round(@word_to_guess, @correct_guesses, @incorrect_guesses)
  end

  def yes_response?
    gets.chomp.to_s.downcase.strip == 'y'
  end
end

game = SharkAttackGame.new
game.play
