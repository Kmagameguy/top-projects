# frozen_string_literal: true

# A class which helps to show the player feedback as the game progresses
class Display
  WAVE_TOP = '.--.'
  WAVE_SPACER = ' '
  SHARK_FIN = '𓂄'
  SWIMMER = '.º¬'
  WAVE_COUNT = 9
  # 𓂄 .--.\s
  SHARK_LINE = "#{SHARK_FIN}#{WAVE_SPACER}#{WAVE_TOP}#{WAVE_SPACER}"
  # .--.\s
  EMPTY_LINE = "#{WAVE_TOP}#{WAVE_SPACER}"

  def update(word, correct_guesses, incorrect_guesses, game_won: nil)
    if game_won.nil?
      draw_round(word, correct_guesses, incorrect_guesses)
    else
      draw_game_over(word, game_won)
    end
  end

  private

  def draw_round(word, correct_guesses = [], incorrect_guesses = [])
    clear_screen
    draw_waves_shark_and_swimmer(incorrect_guesses)
    show_revealed_characters(correct_guesses, word)
    show_incorrectly_guessed_characters(incorrect_guesses)
  end

  def draw_game_over(word, game_won)
    clear_screen
    game_won ? draw_win_message(word) : draw_loss_message(word)
  end

  def draw_win_message(word)
    puts '🏊'
    puts "Congratulations!  You guessed the word (#{word}) and stopped the shark!"
  end

  def draw_loss_message(word)
    puts '🦈🥪'
    puts "Oh no!  You didn't guess the word (#{word}).  The shark made the swimmer its lunch!"
  end

  def clear_screen
    system('clear')
    puts ''
  end

  def draw_waves_shark_and_swimmer(incorrect_guesses)
    shark_position = incorrect_guesses.size
    WAVE_COUNT.times do |index|
      if index == shark_position
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
