# frozen_string_literal: true

# A class which defines our Knight chess piece
class Knight
  attr_accessor :coordinates

  MOVES = [[-1, -2], [1, -2], [2, -1], [2, 1],
           [1, 2],   [-1, 2], [-2, 1], [-2, -1]].freeze

  def initialize(starting_position: [0, 0], board_size: 8)
    @coordinates = starting_position
    @board_size = board_size - 1
  end

  def possible_next_moves(visited_squares)
    x, y = @coordinates
    MOVES.map { |x_offset, y_offset| [x + x_offset, y + y_offset] }
         .reject { |move| out_of_bounds?(move) }
         .reject { |move| already_visited?(move, visited_squares) }
  end

  private

  def out_of_bounds?(move)
    move.any? { |coordinate| coordinate.negative? || coordinate > @board_size }
  end

  def already_visited?(move, squares)
    squares.any? { |square| square.coordinates == move }
  end
end
