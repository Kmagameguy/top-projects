# frozen_string_literal: true

# A module which helps to show the player feedback as the game progresses
module Displayable
  WAVE_TOP = '.--.'
  WAVE_SPACER = ' '
  SHARK_FIN = '𓂄'
  SWIMMER = '.º¬'
  WAVE_COUNT = 9
  # 𓂄 .--.\s
  SHARK_LINE = "#{SHARK_FIN}#{WAVE_SPACER}#{WAVE_TOP}#{WAVE_SPACER}"
  # .--.\s
  EMPTY_LINE = "#{WAVE_TOP}#{WAVE_SPACER}"

  def draw_round(word, correct_guesses = [], incorrect_guesses = [])
    clear_screen
    draw_waves_shark_and_swimmer
    show_revealed_characters(correct_guesses, word)
    show_incorrectly_guessed_characters(incorrect_guesses)
  end

  def draw_game_over(word, won: false)
    clear_screen
    if won
      puts '🏊'
      puts "Congratulations!  You guessed the word (#{word}) and stopped the shark!"
    else
      puts '🦈🥪'
      puts "Oh no!  You didn't guess the word (#{word}).  The shark made the swimmer its lunch!"
    end
  end

  private

  def clear_screen
    system('clear')
    puts ''
  end

  def draw_waves_shark_and_swimmer
    WAVE_COUNT.times do |index|
      if index == @shark_position
        print SHARK_LINE
      else
        print EMPTY_LINE
      end
    end
    print "#{SWIMMER}\n"
  end

  def show_revealed_characters(characters_to_display, word)
    puts ''
    print word.chars.map { |char| characters_to_display.include?(char) ? char : '_' }.join(' ')
    puts ''
  end

  def show_incorrectly_guessed_characters(characters)
    puts "Incorrect Guesses: #{characters.join(', ')}" unless characters.empty?
  end
end
