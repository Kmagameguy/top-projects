# frozen_string_literal: true

# A module which is concerned with movements
module Movable
  def sliding_diagonal_moves(position, squares)
    upleft_moves(position, squares).concat(upright_moves(position, squares))
                                   .concat(downleft_moves(position, squares))
                                   .concat(downright_moves(position, squares))
                                   .sort
  end

  def sliding_straight_moves(position, squares)
    top_vertical_moves(position, squares).concat(bottom_vertical_moves(position, squares))
                                         .concat(left_horizontal_moves(position, squares))
                                         .concat(right_horizontal_moves(position, squares))
                                         .sort
  end

  def single_diagonal_moves(position, squares)
    upleft_move(position, squares).concat(upright_move(position, squares))
                                  .concat(downleft_move(position, squares))
                                  .concat(downright_move(position, squares))
                                  .sort
  end

  def single_straight_moves(position, squares)
    top_vertical_move(position, squares).concat(bottom_vertical_move(position, squares))
                                        .concat(left_horizontal_move(position, squares))
                                        .concat(right_horizontal_move(position, squares))
  end

  def upleft_move(position, squares)
    [upleft_moves(position, squares).first].compact
  end

  def top_vertical_move(position, squares)
    [top_vertical_moves(position, squares).first].compact
  end

  def upright_move(position, squares)
    [upright_moves(position, squares).first].compact
  end

  def right_horizontal_move(position, squares)
    [right_horizontal_moves(position, squares).first].compact
  end

  def downright_move(position, squares)
    [downright_moves(position, squares).first].compact
  end

  def bottom_vertical_move(position, squares)
    [bottom_vertical_moves(position, squares).first].compact
  end

  def downleft_move(position, squares)
    [downleft_moves(position, squares).first].compact
  end

  def left_horizontal_move(position, squares)
    [downleft_moves(position, squares).first].compact
  end

  def upleft_moves(position, squares)
    row, column = position
    moves = []

    until row.zero? || column.zero?
      row -= 1
      column -= 1
      next_step = [row, column]
      if blocked?(next_step, squares)
        moves << next_step if killing_move?(next_step, squares)
        break
      end

      moves << next_step
    end
    moves
  end

  def upright_moves(position, squares)
    row, column = position
    moves = []

    until row.zero? || column == (squares.size - 1)
      row -= 1
      column += 1
      next_step = [row, column]

      if blocked?(next_step, squares)
        moves << next_step if killing_move?(next_step, squares)
        break
      end

      moves << next_step
    end
    moves
  end

  def downleft_moves(position, squares)
    row, column = position
    moves = []

    until row == (squares.size - 1) || column.zero?
      row += 1
      column -= 1
      next_step = [row, column]

      if blocked?(next_step, squares)
        moves << next_step if killing_move?(next_step, squares)
        break
      end

      moves << next_step
    end
    moves
  end

  def downright_moves(position, squares)
    row, column = position
    moves = []

    until row == (squares.size - 1) || column == (squares.size - 1)
      row += 1
      column += 1
      next_step = [row, column]

      if blocked?(next_step, squares)
        moves << next_step if killing_move?(next_step, squares)
        break
      end

      moves << next_step
    end
    moves
  end

  def top_vertical_moves(position, squares)
    row, column = position
    moves = []

    until row.zero?
      row -= 1
      next_step = [row, column]

      if blocked?(next_step, squares)
        moves << next_step if killing_move?(next_step, squares)
        break
      end

      moves << next_step
    end
    moves
  end

  def bottom_vertical_moves(position, squares)
    row, column = position
    moves = []

    until row == (squares.size - 1)
      row += 1
      next_step = [row, column]

      if blocked?(next_step, squares)
        moves << next_step if killing_move?(next_step, squares)
        break
      end

      moves << next_step
    end
    moves
  end

  def left_horizontal_moves(position, squares)
    row, column = position
    moves = []

    until column.zero?
      column -= 1
      next_step = [row, column]

      if blocked?(next_step, squares)
        moves << next_step if killing_move?(next_step, squares)
        break
      end

      moves << next_step
    end
    moves
  end

  def right_horizontal_moves(position, squares)
    row, column = position
    moves = []

    until column == (squares.size - 1)
      column += 1
      next_step = [row, column]

      if blocked?(next_step, squares)
        moves << next_step if killing_move?(next_step, squares)
        break
      end

      moves << next_step
    end
    moves
  end

  def blocked?(move, squares)
    row, column = move
    !squares.dig(row, column).nil?
  end

  def killing_move?(move, squares)
    row, column = move
    piece = squares.dig(row, column)

    return false if piece.nil?

    piece.color != color
  end

  def out_of_bounds?(move, squares)
    move.any? { |coordinate| (coordinate.negative? || coordinate > squares.size - 1) }
  end
end
