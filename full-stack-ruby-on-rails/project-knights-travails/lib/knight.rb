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
    moves = MOVES.map { |x_offset, y_offset| [x + x_offset, y + y_offset] }
    moves = moves.reject { |move| out_of_bounds?(move) } # .reject, nice, thanks RuboCop
    moves.reject { |move| already_visited?(move, visited_squares) }
  end

  def knight_moves; end

  private

  def out_of_bounds?(move)
    move.any? { |coordinate| coordinate.negative? || coordinate > @board_size }
  end

  def already_visited?(move, squares)
    squares.any? { |square| square.coordinates == move }
  end
end

# Valid moves (Where "x" is current position):
#       0        1        2        3        4        5        6        7
# 0 [      ] [      ] [      ] [      ] [      ] [      ] [      ] [      ]
# 1 [      ] [      ] [      ] [      ] [      ] [      ] [      ] [      ]
# 2 [      ] [      ] [-1, -2] [      ] [1, -2 ] [      ] [      ] [      ]
# 3 [      ] [-2, -1] [      ] [      ] [      ] [ 2, -1] [      ] [      ]
# 4 [      ] [      ] [      ] [   x  ] [      ] [      ] [      ] [      ]
# 5 [      ] [ -2, 1] [      ] [      ] [      ] [ 2, 1 ] [      ] [      ]
# 6 [      ] [      ] [ -1, 2] [      ] [ 1, 2 ] [      ] [      ] [      ]
# 7 [      ] [      ] [      ] [      ] [      ] [      ] [      ] [      ]

# As a Knight, I:
# Can traverse:
#   [-2, -1] OR
#   [-2,  1] OR
#   [-1, -2] OR
#   [-1,  2] OR
#   [1,  -2] OR
#   [1,   2] OR
#   [2,  -1]
