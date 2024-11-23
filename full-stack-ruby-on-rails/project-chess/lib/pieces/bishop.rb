# frozen_string_literal: true

require_relative 'piece'
require_relative '../slidable'

class Bishop < Piece
  include Slidable
  def possible_moves(board)
    diagonal_moves(position, board)
  end

  def to_s
    white? ? '♗' : '♝'
  end
end
