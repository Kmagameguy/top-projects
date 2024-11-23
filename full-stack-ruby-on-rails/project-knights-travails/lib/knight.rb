# frozen_string_literal: true

# A class which defines our Knight chess piece
class Knight
  attr_accessor :coordinates

  MOVES = [[-1, -2], [1, -2], [2, -1], [2, 1],
           [1, 2],  [-1, 2],  [-2, 1],  [-2, -1]].freeze

  def initialize(starting_position = [0, 0])
    @coordinates = starting_position
  end

  def possible_next_moves
    x, y = @coordinates
    moves = MOVES.map { |x_offset, y_offset| [x + x_offset, y + y_offset] }
    moves.reject { |move| out_of_bounds?(move) } # .reject, nice, thanks RuboCop
  end

  def knight_moves; end

  private

  def out_of_bounds?(move)
    # board_boundary is hopefully temporary... i want to be able to evaluate
    # jumps for any size board...which we can eventually get from
    # the game_board i think.
    board_boundary = 7
    move.any? { |coordinate| coordinate.negative? || coordinate > board_boundary }
  end
end

k = Knight.new([3, 4])
puts "Starting position: #{k.coordinates}"
p k.possible_next_moves

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
