# frozen_string_literal: true

require_relative 'piece'

# A King piece in a chess game
class King < Piece
  def initialize(color, position)
    super
    @checked = false
    @mated = false
  end

  def possible_moves(board)
    single_straight_moves(position, board).concat(single_diagonal_moves(position, board))
  end

  def to_s
    white? ? '♔' : '♚'
  end
end
