# frozen_string_literal: true

# A class to manage user inputs
class Input
  attr_reader :first_location, :second_location

  CHESS_NOTATION_REGEX = /^([a-h])([1-8])\s?([a-h])([1-8])/i.freeze

  def initialize
    @string = validate_input
    @first_location = location((1..2))
    @second_location = location((3..4))
  end

  def validate_input
    loop do
      input = user_input
      return input if chess_notation?(input)

      puts 'Invalid input.  Try [Letter][Number] [Letter][Number]'
    end
  end

  def user_input
    gets.chomp.strip
  end

  def chess_notation?(input)
    input.match?(CHESS_NOTATION_REGEX)
  end

  def location(range)
    @string.match(CHESS_NOTATION_REGEX)[range].join('')
  end
end