# frozen_string_literal: true

require_relative 'piece'
require_relative '../slidable'

# A Rook piece in a chess game
class Rook < Piece
  include Slidable

  def possible_moves(board)
    straight_moves(position, board)
  end

  def to_s
    white? ? '♖' : '♜'
  end
end
