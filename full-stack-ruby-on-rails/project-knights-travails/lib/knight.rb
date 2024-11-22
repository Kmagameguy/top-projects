# frozen_string_literal: true

# A class which defines our Knight chess piece
class Knight
  MOVES = [[-1, -2], [-2, -1], [-2, 1], [-1, 2],
           [1, -2],  [2, -1],  [2, 1],  [1, 2]].freeze

  def initialize; end

  def knight_moves; end
end

# Valid moves (Where "0, 0" is current position):
#       0        1        2        3        4        5        6        7
# 0 [      ] [      ] [      ] [      ] [      ] [      ] [      ] [      ]
# 1 [      ] [      ] [      ] [      ] [      ] [      ] [      ] [      ]
# 2 [      ] [      ] [-1, -2] [      ] [1, -2 ] [      ] [      ] [      ]
# 3 [      ] [-2, -1] [      ] [      ] [      ] [ 2, -1] [      ] [      ]
# 4 [      ] [      ] [      ] [ 0, 0 ] [      ] [      ] [      ] [      ]
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
