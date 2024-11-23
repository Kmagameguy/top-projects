# frozen_string_literal: true

require_relative './pieces/pawn'
require_relative './pieces/rook'
require_relative './pieces/knight'
require_relative './pieces/bishop'
require_relative './pieces/queen'
require_relative './pieces/king'

# A class to manage our chess board and its state
class Board
  attr_reader :size, :squares

  def initialize
    @size = 8
    @squares = Array.new(size) { Array.new(size) }
    setup_board
  end

  def setup_board
    add_pawns
    add_special_pieces
  end

  def square(coordinates)
    row, column = coordinates
    squares[row][column]
  end

  def update!(piece, new_square)
    l_rank, l_file = piece.position
    n_rank, n_file = new_square

    piece.move!(new_square)

    squares[l_rank][l_file] = nil
    squares[n_rank][n_file] = piece
  end

  def check?(defender_color, attacker_color)
    defender_king_position = find_king(defender_color)
    attacker_pieces = find_pieces(attacker_color)
    attacker_pieces.any? do |piece|
      piece.possible_moves(squares).include?(defender_king_position)
    end
  end

  def find_king(color)
    find_pieces(color).find { |piece| piece.is_a? King }.position
  end

  def find_pieces(color)
    squares.flatten.compact.select { |piece| piece.color == color }
  end

  private

  def default_special_pieces
    [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  end

  def add_pawns
    black_pawn_rank = 1
    white_pawn_rank = 6

    size.times do |file|
      squares[black_pawn_rank][file] = Pawn.new(:black, [black_pawn_rank, file])
      squares[white_pawn_rank][file] = Pawn.new(:white, [white_pawn_rank, file])
    end
  end

  def add_special_pieces
    black_special_piece_rank = 0
    white_special_piece_rank = 7

    default_special_pieces.each_with_index do |piece, file|
      squares[black_special_piece_rank][file] = piece.new(:black, [black_special_piece_rank, file])
      squares[white_special_piece_rank][file] = piece.new(:white, [white_special_piece_rank, file])
    end
  end
end
