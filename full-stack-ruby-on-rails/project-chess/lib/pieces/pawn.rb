# frozen_string_literal: true

require_relative 'piece'

# A Pawn piece in a chess game
class Pawn < Piece
  MOVES_SET = [[1, 0], [2, 0]].freeze

  attr_accessor :rushing
  attr_reader :en_passantable_left, :en_passantable_right

  def initialize(color, position)
    super
    @rushing = false
    @en_passantable_left = []
    @en_passantable_right = []
  end

  def move!(coordinates)
    update_rushing(coordinates)
    super
  end

  def possible_moves(squares)
    move_set(squares).concat(attackable_squares(squares))
                     .concat(en_passantable_squares(squares))
                     .reject { |move| out_of_bounds?(move, squares) }
  end

  def promote?
    (position[0].zero? || position[0] == 7)
  end

  def rushing?
    @rushing
  end

  def forward_move?(destination)
    x, y = position
    forward_direction = white? ? [[x - 1, y], [x - 2, y]] : [[x + 1, y], [x + 2, y]]
    forward_direction.include?(destination)
  end

  def to_s
    white? ? '♙' : '♟︎'
  end

  private

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

  def en_passantable_squares(squares)
    pawn_rank = position[0]

    pawn_left = if white?
                  position[1] - 1
                else
                  position[1] + 1
                end

    pawn_right = if white?
                   position[1] + 1
                 else
                   position[1] - 1
                 end

    adjacent_left = squares[pawn_rank][pawn_left]
    adjacent_right = squares[pawn_rank][pawn_right]

    adjacent_squares = []
    @en_passantable_left = []
    @en_passantable_right = []

    @en_passantable_left = [pawn_rank, pawn_left] if other_rushing?(adjacent_left)
    @en_passantable_right = [pawn_rank, pawn_right] if other_rushing?(adjacent_right)

    if white?
      adjacent_squares << left_diag if other_rushing?(adjacent_left)
      adjacent_squares << right_diag if other_rushing?(adjacent_right)
    else
      adjacent_squares << right_diag if other_rushing?(adjacent_left)
      adjacent_squares << left_diag if other_rushing?(adjacent_right)
    end

    adjacent_squares
  end

  def other_rushing?(square)
    square.is_a?(Pawn) && square.rushing?
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

  def update_rushing(coordinates)
    prev_rank = coordinates[0]
    new_rank = position[0]
    @rushing = if white?
                 prev_rank == (new_rank - 2)
               else
                 prev_rank == (new_rank + 2)
               end
  end
end
