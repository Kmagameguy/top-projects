# frozen_string_literal: true

require_relative 'piece'

class Bishop < Piece
  def possible_moves(board)
    sliding_diagonal_moves(position, board)
  end

  def trapped?(board)
    possible_moves(board).empty?
  end

  def to_s
    white? ? '♗' : '♝'
  end
end
