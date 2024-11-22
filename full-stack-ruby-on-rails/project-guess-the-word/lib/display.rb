# frozen_string_literal: true

class Display
  attr_accessor :shark_position

  WAVE_TOP = '.--.'
  WAVE_SPACER = ' '
  SHARK_FIN = '𓂄'
  SWIMMER = '.º¬'
  WAVE_COUNT = 9
  # 𓂄 .--.\s
  SHARK_LINE = "#{SHARK_FIN}#{WAVE_SPACER}#{WAVE_TOP}#{WAVE_SPACER}"
  # .--.\s
  EMPTY_LINE = "#{WAVE_TOP}#{WAVE_SPACER}"

  def initialize
    @shark_position = 0
  end

  def draw
    clear_screen
    draw_waves_shark_and_swimmer
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
end
