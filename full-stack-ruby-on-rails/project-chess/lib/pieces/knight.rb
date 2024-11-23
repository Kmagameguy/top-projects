# frozen_string_literal: true

require_relative 'piece'

# A Knight piece in a chess game
class Knight < Piece
  MOVES = [[-1, -2], [1, -2], [2, -1], [2, 1],
           [1, 2], [-1, 2], [-2, 1], [-2, -1]].freeze

  def possible_moves(board)
    x, y = position
    MOVES.map { |x_offset, y_offset| [x + x_offset, y + y_offset] }
         .reject { |move| out_of_bounds?(move, board) }
         .reject { |move| blocked?(move, board) && !killing_move?(move, board) }
  end

  def trapped?(board)
    possible_moves(board).empty?
  end

  def to_s
    white? ? '♘' : '♞'
  end
end
