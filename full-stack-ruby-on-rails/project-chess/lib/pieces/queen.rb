# frozen_string_literal: true

require_relative 'piece'
require_relative '../slidable'

# A Queen piece in a chess game
class Queen < Piece
  include Slidable

  def possible_moves(board)
    straight_moves(position, board).concat(diagonal_moves(position, board))
  end

  def to_s
    white? ? '♕' : '♛'
  end
end
