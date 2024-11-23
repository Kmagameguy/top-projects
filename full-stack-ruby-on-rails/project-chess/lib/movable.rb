# frozen_string_literal: true

# A module which is concerned with movements
module Movable
  def sliding_diagonal_moves(position, board)
    upleft_moves(position, board).concat(upright_moves(position, board))
                                 .concat(downleft_moves(position, board))
                                 .concat(downright_moves(position, board))
                                 .sort
  end

  def sliding_straight_moves(position, board)
    top_vertical_moves(position, board).concat(bottom_vertical_moves(position, board))
                                       .concat(left_horizontal_moves(position, board))
                                       .concat(right_horizontal_moves(position, board))
                                       .sort
  end

  def single_diagonal_moves(position, board)
    upleft_move(position, board).concat(upright_move(position, board))
                                .concat(downleft_move(position, board))
                                .concat(downright_move(position, board))
                                .sort
  end

  def single_straight_moves(position, board)
    top_vertical_move(position, board).concat(bottom_vertical_move(position, board))
                                      .concat(left_horizontal_move(position, board))
                                      .concat(right_horizontal_move(position, board))
  end

  def upleft_move(position, board)
    [upleft_moves(position, board).first].compact
  end

  def top_vertical_move(position, board)
    [top_vertical_moves(position, board).first].compact
  end

  def upright_move(position, board)
    [upright_moves(position, board).first].compact
  end

  def right_horizontal_move(position, board)
    [right_horizontal_moves(position, board).first].compact
  end

  def downright_move(position, board)
    [downright_moves(position, board).first].compact
  end

  def bottom_vertical_move(position, board)
    [bottom_vertical_moves(position, board).first].compact
  end

  def downleft_move(position, board)
    [downleft_moves(position, board).first].compact
  end

  def left_horizontal_move(position, board)
    [downleft_moves(position, board).first].compact
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

  def left_horizontal_moves(position, board)
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

  def blocked?(move, board)
    x, y = move
    !board.dig(x, y).nil?
  end

  def killing_move?(move, board)
    x, y = move
    piece = board.dig(x, y)

    return false if piece.nil?

    piece.color != color
  end

  def out_of_bounds?(move, board)
    move.any? { |coordinate| (coordinate.negative? || coordinate > board.size - 1) }
  end
end
