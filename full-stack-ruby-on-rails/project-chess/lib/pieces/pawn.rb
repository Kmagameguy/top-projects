# frozen_string_literal: true

require_relative 'piece'

# A Pawn piece in a chess game
class Pawn < Piece
  ONE_STEP = [1, 0].freeze
  TWO_STEP = [2, 0].freeze

  def possible_moves(squares)
    x, y = position
    move_set.map { |offset_x, offset_y| [x + offset_x, y + offset_y] }
            .reject { |move| blocked?(move, squares) }
            .concat(attackable_squares(squares))
            .reject { |move| out_of_bounds?(move, squares) }
  end

  def move_set
    moves = moved? ? [ONE_STEP] : [TWO_STEP, ONE_STEP]
    moves = invert(moves) if color == :white
    moves
  end

  def attackable_squares(squares)
    attackable_squares = []

    l_rank, l_file = left_diag
    r_rank, r_file = right_diag

    attackable_squares << left_diag unless squares[l_rank][l_file].nil?
    attackable_squares << right_diag unless squares[r_rank][r_file].nil?

    attackable_squares
  end

  def left_diag
    rank, file = position

    if color == :white
      [rank - 1, file - 1]
    else
      [rank + 1, file - 1]
    end
  end

  def right_diag
    rank, file = position

    if color == :white
      [rank - 1, file + 1]
    else
      [rank + 1, file + 1]
    end
  end

  def invert(moves)
    moves.map { |x, y| [x * -1, y * -1] }
  end

  def promote?
    (position[0].zero? || position[0] == 7)
  end

  def to_s
    white? ? '♙' : '♟︎'
  end
end
