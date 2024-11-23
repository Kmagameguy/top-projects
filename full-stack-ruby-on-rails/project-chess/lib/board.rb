# frozen_string_literal: true

require_relative './pieces/pawn'
require_relative './pieces/rook'


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
    add_rooks
    #add_special_pieces
  end

  def add_rooks
    black_rook_rank = 0
    white_rook_rank = 7

    rook1_file = 0
    rook2_file = 7

    squares[black_rook_rank][rook1_file] = Rook.new(:black, [black_rook_rank, rook1_file])
    squares[black_rook_rank][rook2_file] = Rook.new(:black, [black_rook_rank, rook2_file])

    squares[white_rook_rank][rook1_file] = Rook.new(:white, [white_rook_rank, rook1_file])
    squares[white_rook_rank][rook2_file] = Rook.new(:white, [white_rook_rank, rook2_file])
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
    pieces = [:rook, :knight, :bishop, :queen, :king, :bishop, :knight, :rook]
    black_special_piece_row = squares[0]
    white_special_piece_row = squares[7]

    size.times do |column|
      black_special_piece_row[column] = Piece.new(:black, pieces[column])
      white_special_piece_row[column] = Piece.new(:white, pieces[column])
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
