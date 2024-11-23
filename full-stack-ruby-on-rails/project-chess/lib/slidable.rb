# frozen_string_literal: true

# A module which is concerned with sliding-style movements
module Slidable
  def diagonal_moves(position, board)
    upleft_moves(position, board).concat(upright_moves(position, board))
                                 .concat(downleft_moves(position, board))
                                 .concat(downright_moves(position, board))
                                 .sort
  end

  def straight_moves(position, board)
    top_vertical_moves(position, board).concat(bottom_vertical_moves(position, board))
                                       .concat(left_horizontal_moves(position, board))
                                       .concat(right_horizontal_moves(position, board))
                                       .sort
  end

  def upleft_moves(position, board)
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

  def upright_moves(position, board)
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

  def downleft_moves(position, board)
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

  def downright_moves(position, board)
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

  def top_vertical_moves(position, board)
    row, column = position
    moves = []

    until row == 0
      row -= 1
      next_step = [row, column]

      if blocked?(next_step, board)
        moves << next_step if killing_move?(next_step, board)
        break
      end

      moves << next_step
    end
    moves
  end

  def bottom_vertical_moves(position, board)
    row, column = position
    moves = []

    until row == (board.size - 1)
      row += 1
      next_step = [row, column]

      if blocked?(next_step, board)
        moves << next_step if killing_move?(next_step, board)
        break
      end

      moves << next_step
    end
    moves
  end

  def left_horizontal_moves(board)
    row, column = position
    moves = []

    until column == 0
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

  def right_horizontal_moves(position, board)
    row, column = position
    moves = []

    until column == (board.size - 1)
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
end
