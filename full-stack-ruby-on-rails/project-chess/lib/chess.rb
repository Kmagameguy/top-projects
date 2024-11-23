# frozen_string_literal: true

require_relative 'board'

# A class to manage the state of a chess game
class Chess
  def initialize
    @board = Board.new
  end

  def chess_notation_to_array_notation(chess_notation)
    [indexed_alphabet[first_char(chess_notation)], second_char(chess_notation)]
  end

  private

  def indexed_alphabet
    ('a'..'z').each_with_object({}).with_index do |(letter, hash), index|
      hash[letter] = index
    end
  end

  def first_char(string)
    string.strip.chars.first.downcase
  end

  def second_char(string)
    string.strip.chars.last.to_i
  end
end
