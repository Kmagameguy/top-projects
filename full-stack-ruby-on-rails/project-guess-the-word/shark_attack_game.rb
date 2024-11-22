# frozen_string_literal: true

require './lib/word'
require './lib/display'

# A class to manage our game's state
class SharkAttackGame
  def initialize
    @word_to_guess = Word.new
    @display = Display.new
    @display.draw(@word_to_guess)
  end

  def play
    # Debugging line:
    puts @word_to_guess.word
    p "Incorrect List: #{@word_to_guess.incorrect_guesses}"
    p "Correct List: #{@word_to_guess.correct_guesses}"

    choose_letter
    @display.shark_position = @word_to_guess.incorrect_guesses.size
    @display.draw(@word_to_guess)
    play unless game_over?
  end

  private

  def game_over?
    game_won || game_lost
  end

  def game_won
    @word_to_guess.correct_guesses.length == @word_to_guess.word.chars.uniq.length
  end

  def game_lost
    @display.shark_position >= Display::WAVE_COUNT
  end

  def choose_letter
    puts 'Guess a letter:'
    input = gets.chomp

    if invalid_input?(input)
      puts 'Try again:'
      choose_letter
    else
      @word_to_guess.save_input(input)
    end
  end

  def invalid_input?(input)
    (input.length > 1 ||
      @word_to_guess.correct_guesses.include?(input) ||
      @word_to_guess.incorrect_guesses.include?(input))
  end
end

game = SharkAttackGame.new
game.play

# How the game works:
# A list of words is provided to the system, from which one is randomly selected.
# Players are given 9 turns to guess the letters which make up the word.
# If a player guesses wrong, the shark advances one space to the right, towards the swimmer.
# If the players make 9 incorrect guesses, the shark catches the swimmer and the game is lost.
# Otherwise, each correct guess reveals the position of the matching letters and no other action occurs.
# Once the word is fully revealed the game ends -- the players have stopped the shark attack!

# Additional notes & constraints:
# 1. Odin wants the word selection to be between 5 and 12 characters
#    - Need to read-in the Google 1000 words list and filter anything less than 5 char and larger than 12 char
# 2. Need to display the number of remaining guesses (show the shark's progress towards the swimmer)
# 3. Display the word
#    - Start by replacing the word's letters with underscores
#    - Whenever a letter is revealed, make sure that's printed instead of the underscores
# 4. Keep track of player guesses - don't let them guess the same letter twice
#    - Letter comparisons should be case INsensistive
# 5. Once the base gameplay is working, allow the player to save their game
# 6. Then, once serialization is complete, allow the player to load a saved game

# The "stuff" we need:
# 1. A Display to draw the gameplay:
#    - 9 waves + swimmer
#    - Shark fin progress (state) through the waves
#    - The chosen word state (underscores for unguessed, + guessed characters)
#    - A list of incorrectly guessed letters
# 2. Word class to track the guessed letters state
#    - A list of correct letters (which are printed to screen)
#    - A list of incorrect letters (which are printed to screen)
# 3. A Player class to handle inputs(?)

# Gameplay loop:
# 1. Prompt player if they would like to load a saved game (extra: if a saved game exists?)
# 2. New Game: Pick a new word
# 3. Display the shark, waves, swimmer, and the masked word
# 4. Prompt player to guess a letter
# 5. Validate that input and:
#     - Store it in either the correct or incorrect guesses list
#     - If correct, reveal the matching letters in the word
#     - If incorrect, move shark one space to the right
# 6. Evaluate game over:
#     - Loss state: shark caught up to swimmer (moved nine spaces to the right)
#     - Win state: All characters in the word are revealed
