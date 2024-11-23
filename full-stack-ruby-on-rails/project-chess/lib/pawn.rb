# frozen_string_literal: true

require_relative 'piece'

# A Pawn piece in a chess game
class Pawn < Piece
  MOVE_SET = [[2, 0], [1, 0]].freeze

  def possible_moves
    x, y = @position
    move_set.map { |offset_x, offset_y| [x + offset_x, y + offset_y] }
  end

  def move_set
    moves = moved? ? [MOVE_SET.last] : MOVE_SET
    if @color == :white
      moves.map { |x, y| [x * -1, y * -1] }
    else
      moves
    end
  end
end
