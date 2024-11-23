# frozen_string_literal: true

require_relative './pieces/pawn'
require_relative './pieces/rook'
require_relative './pieces/knight'
require_relative './pieces/bishop'
require_relative './pieces/queen'
require_relative './pieces/king'

# A class to manage our chess board and its state
class Board
  attr_reader :size, :squares

  def initialize
    @size = 8
    @squares = Array.new(size) { Array.new(size) }
    setup_board
  end

  def setup_board
    add_pawns
    add_special_pieces
  end

  def add_pawns
    black_pawn_rank = 1
    white_pawn_rank = 6

    size.times do |file|
      squares[black_pawn_rank][file] = Pawn.new(:black, [black_pawn_rank, file])
      squares[white_pawn_rank][file] = Pawn.new(:white, [white_pawn_rank, file])
    end
  end

  def add_special_pieces
    black_special_piece_row = 0
    white_special_piece_row = 7
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    pieces.each_with_index do |piece, column|
      squares[black_special_piece_row][column] = piece.new(:black, [black_special_piece_row, column])
      squares[white_special_piece_row][column] = piece.new(:white, [white_special_piece_row, column])
    end
  end

  def update(last_square, new_square)
    l_rank, l_file = last_square
    n_rank, n_file = new_square

    piece = squares[l_rank][l_file]
    piece.move(new_square)

    squares[l_rank][l_file] = nil
    squares[n_rank][n_file] = piece
  end

  # convenience method for now...
  def to_s
    num_squares = size
    squares.each_with_index do |row, index|
      print "#{num_squares - index}| "
      row.each do |square|

        if square.is_a?(Piece)
          print square.to_s + ' '
        else
          print '  '
        end

      end
      print '|'
      puts ''
    end
    print '   '
    ('a'..'h').each { |letter| print letter.to_s + ' ' }
    puts ''
  end
end

# board:
# (0) 8 [♜] [♞] [♝] [♛] [♚] [♝] [♞] [♜]
# (1) 7 [♟︎] [♟︎] [♟︎] [♟︎] [♟︎] [♟︎] [♟︎] [♟︎]
# (2) 6 [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ]
# (3) 5 [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ]
# (4) 4 [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ]
# (5) 3 [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ]
# (6) 2 [♙] [♙] [♙] [♙] [♙] [♙] [♙] [♙]
# (7) 1 [♖] [♘] [♗] [♕] [♔] [♗] [♘] [♖]
#        a   b   c   d   e   f   g   h
#       (0) (1) (2) (3) (4) (5) (6) (7)
