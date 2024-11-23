# frozen_string_literal: true

require_relative 'piece'

# A Rook piece in a chess game
class Rook < Piece
  def possible_moves(board)
    sliding_straight_moves(position, board)
  end

  def to_s
    white? ? '♖' : '♜'
  end
end
