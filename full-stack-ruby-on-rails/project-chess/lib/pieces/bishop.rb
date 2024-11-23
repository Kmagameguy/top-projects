# frozen_string_literal: true

require_relative 'piece'

class Bishop < Piece
  def possible_moves(board)
    move_set(board)
  end

  def move_set(board)
    upleft_moves(board).concat(upright_moves(board))
                       .concat(downleft_moves(board))
                       .concat(downright_moves(board))
                       .sort
  end

  def upleft_moves(board)
    row, column = position
    moves = []

    until row == 0 || column == 0
      row -= 1
      column -= 1
      next_step = [row, column]
      if blocked?(next_step, board)
        moves << next_step if killing_move?(next_step, board)
        break
      end

      moves << next_step
    end
    moves
  end

  def upright_moves(board)
    row, column = position
    moves = []

    until row == 0 || column == (board.size - 1)
      row -= 1
      column += 1
      next_step = [row, column]

      if blocked?(next_step, board)
        moves << next_step if killing_move?(next_step, board)
        break
      end

      moves << next_step
    end
    moves
  end

  def downleft_moves(board)
    row, column = position
    moves = []

    until row == (board.size - 1) || column == 0
      row += 1
      column -= 1
      next_step = [row, column]

      if blocked?(next_step, board)
        moves << next_step if killing_move?(next_step, board)
        break
      end

      moves << next_step
    end
    moves
  end

  def downright_moves(board)
    row, column = position
    moves = []

    until row == (board.size - 1) || column == (board.size - 1)
      row += 1
      column += 1
      next_step = [row, column]

      if blocked?(next_step, board)
        moves << next_step if killing_move?(next_step, board)
        break
      end

      moves << next_step
    end
    moves
  end

  def to_s
    white? ? '♗' : '♝'
  end
end
