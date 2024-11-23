# frozen_string_literal: true

require_relative 'board'

# A class to manage the state of a chess game
class Chess
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def chess_notation_to_array(chess_notation)
    [rank(chess_notation), file(chess_notation)]
  end

  def make_move(from, to)
    from = chess_notation_to_array(from)
    to = chess_notation_to_array(to)

    board.update(from, to) if valid_move?(from, to)
  end

  def valid_move?(square, move)
    square_rank, square_file = square
    piece = board.squares[square_rank][square_file]

    piece.possible_moves(board.squares).include?(move)
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
    indexed_alphabet[string.strip.chars.first.downcase]
  end
end
