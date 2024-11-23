# frozen_string_literal: true

require_relative 'piece'

# A Rook piece in a chess game
class Rook < Piece
  def possible_moves(board)
    move_set(board)
  end

  def move_set(board)
    horizontal_moves(board).concat(vertical_moves(board)).sort
  end

  def vertical_moves(board)
    top_vertical_moves(board).concat(bottom_vertical_moves(board))
  end

  def top_vertical_moves(board)
    x, y = position
    moves = []

    until x == 0
      x -= 1
      if blocked?([x, y], board)
        moves << [x, y] if killing_move?([x, y], board)
        break
      end

      moves << [x, y]
    end
    moves
  end

  def bottom_vertical_moves(board)
    x, y = position
    moves = []

    until x == (board.size - 1)
      x += 1
      if blocked?([x, y], board)
        moves << [x, y] if killing_move?([x, y], board)
        break
      end

      moves << [x, y]
    end
    moves
  end

  def horizontal_moves(board)
    left_horizontal_moves(board).concat(right_horizontal_moves(board))
  end

  def left_horizontal_moves(board)
    x, y = position
    moves = []

    until y == 0
      y -= 1
      if blocked?([x, y], board)
        moves << [x, y] if killing_move?([x, y], board)
        break
      end

      moves << [x, y]
    end
    moves
  end

  def right_horizontal_moves(board)
    x, y = position
    moves = []

    until y == (board.size - 1)
      y += 1
      if blocked?([x, y], board)
        moves << [x, y] if killing_move?([x, y], board)
        break
      end

      moves << [x, y]
    end
    moves
  end

  def to_s
    white? ? '♖' : '♜'
  end
end
