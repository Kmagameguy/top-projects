# frozen_string_literal: true

# A class to manage user inputs
class Input
  attr_reader :quit, :first_location, :second_location

  CHESS_NOTATION_REGEX = /^([a-h])([1-8])\s?([a-h])([1-8])/i.freeze

  def initialize
    @string = validate_input
    @quit = quit?(@string)
    @first_location = @quit ? nil : location((1..2))
    @second_location = @quit ? nil : location((3..4))
  end

  def validate_input
    loop do
      input = self.class.user_input.downcase
      return input if chess_notation?(input) || quit?(input)

      puts 'Invalid input.  Try [Letter][Number] [Letter][Number]'
    end
  end

  def self.user_input
    gets.chomp.strip
  end

  def self.valid_name?(name)
    !name.strip.empty?
  end

  def self.yes_response?
    user_input.downcase == 'y'
  end

  def self.promote_piece
    puts 'Type "Rook", "Knight", "Bishop" or "Queen" to promote pawn:'
    loop do
      input = user_input.downcase
      return input if valid_piece?(input)

      puts 'Invalid input. Try again.'
    end
  end

  def self.valid_piece?(input)
    %w[rook knight bishop queen].include?(input)
  end

  def chess_notation?(input)
    input.match?(CHESS_NOTATION_REGEX)
  end

  def quit?(input)
    input.downcase == 'quit game'
  end

  def location(range)
    @string.match(CHESS_NOTATION_REGEX)[range].join('')
  end
end
