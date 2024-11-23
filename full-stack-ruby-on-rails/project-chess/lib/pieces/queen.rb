# frozen_string_literal: true

require_relative 'piece'

# A Queen piece in a chess game
class Queen < Piece
  def possible_moves(board)
    sliding_straight_moves(position, board).concat(sliding_diagonal_moves(position, board))
  end

  def to_s
    white? ? '♕' : '♛'
  end
end
