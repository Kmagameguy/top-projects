# frozen_string_literal: true

require_relative 'board'

# A class to manage the state of a chess game
class Chess
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def chess_notation_to_array_notation(chess_notation)
    [rank(chess_notation), indexed_alphabet[file(chess_notation)]]
  end

  def valid_move?(piece, move)
    m = piece.possible_moves
             .reject { |p_move| out_of_bounds?(p_move) }

    m = m.reject { |p_move| blocked?(p_move) } if piece.is_a? Pawn

    m.include?(move)
  end

  def blocked?(move)
    x, y = move
    !board.squares.dig(x, y).nil?
  end

  def out_of_bounds?(move)
    move.any? { |coordinate| coordinate.negative? || coordinate > board.size - 1 }
  end

  private

  def indexed_alphabet
    ('a'..'h').each_with_object({}).with_index do |(letter, hash), index|
      hash[letter] = index
    end
  end

  def rank(string)
    board.size - string.strip.chars.last.to_i
  end

  def file(string)
    string.strip.chars.first.downcase
  end
end
