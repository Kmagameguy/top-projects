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

  SIZE = 8

  def initialize
    @size = SIZE
    @squares = Array.new(size) { Array.new(size) }
    setup_board!
  end

  def setup_board!
    add_pawns!
    add_special_pieces!
  end

  def square(coordinates)
    row, column = coordinates
    squares[row][column]
  end

  def update!(piece, new_square)
    destroy_piece!(piece.position)
    destroy_en_passanted_pawns!(piece, new_square)
    piece.move!(new_square)

    update_square!(piece)
  end

  def destroy_en_passanted_pawns!(piece, destination)
    return unless piece.is_a?(Pawn)
    return if piece.forward_move?(destination)

    if !piece.en_passantable_left.empty?
      destroy_piece!(piece.en_passantable_left)
    elsif !piece.en_passantable_right.empty?
      destroy_piece!(piece.en_passantable_right)
    end
  end

  def create_piece!(coordinates, piece, color)
    x, y = coordinates
    squares[x][y] = piece.new(color, coordinates)
  end

  def destroy_piece!(coordinates)
    x, y = coordinates
    squares[x][y] = nil
  end

  def update_square!(piece)
    x, y = piece.position
    squares[x][y] = piece
  end

  def not_checked?(defender_color, attacker_color)
    !check?(defender_color, attacker_color)
  end

  def check?(defender_color, attacker_color)
    defender_king_position = find_king(defender_color).position
    attacker_pieces = find_pieces(attacker_color)
    attacker_pieces.any? do |piece|
      piece.possible_moves(squares).include?(defender_king_position)
    end
  end

  def find_king(color)
    find_pieces(color).find { |piece| piece.is_a? King }
  end

  def find_pieces(color)
    squares.flatten.compact.select { |piece| piece.color == color }
  end

  def special_pieces
    default_special_pieces.each_with_object({}) do |piece, hash|
      hash[piece.to_s.downcase] = piece
    end
  end

  private

  def default_special_pieces
    [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  end

  def add_pawns!
    black_pawn_rank = 1
    white_pawn_rank = 6

    size.times do |file|
      black_pawn_position = [black_pawn_rank, file]
      white_pawn_position = [white_pawn_rank, file]

      create_piece!(black_pawn_position, Pawn, :black)
      create_piece!(white_pawn_position, Pawn, :white)
    end
  end

  def add_special_pieces!
    black_special_piece_rank = 0
    white_special_piece_rank = 7

    default_special_pieces.each_with_index do |piece, file|
      black_position = [black_special_piece_rank, file]
      white_position = [white_special_piece_rank, file]

      create_piece!(black_position, piece, :black)
      create_piece!(white_position, piece, :white)
    end
  end
end
