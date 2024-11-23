# frozen_string_literal: true

require_relative 'piece'

# A Pawn piece in a chess game
class Pawn < Piece
  MOVES_SET = [[1, 0], [2, 0]].freeze

  def possible_moves(squares)
    move_set(squares).concat(attackable_squares(squares))
                     .reject { |move| out_of_bounds?(move, squares) }
  end

  def move_set(squares)
    moves = next_steps
    return [] if blocked?(moves.first, squares)

    moves.pop if moved? || blocked?(moves.last, squares)
    moves
  end

  def next_steps
    x, y = position
    offsets = white? ? invert(MOVES_SET) : MOVES_SET
    offsets.map { |offset_x, offset_y| [x + offset_x, y + offset_y] }
  end

  def attackable_squares(squares)
    attackable_squares = []

    l_rank, l_file = left_diag
    r_rank, r_file = right_diag

    attackable_squares << left_diag unless squares.dig(l_rank, l_file).nil?
    attackable_squares << right_diag unless squares.dig(r_rank, r_file).nil?

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

  def trapped?(board)
    possible_moves(board).empty?
  end

  def to_s
    white? ? '♙' : '♟︎'
  end
end
