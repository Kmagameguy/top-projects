# frozen_string_literal: true

require_relative 'piece'

# A class to manage our chess board and its state
class Board
  attr_reader :squares

  def initialize
    @squares = Array.new(8) { Array.new(8) }
    setup_board
  end

  def setup_board
    add_pawns
    add_special_pieces
  end

  def add_pawns
    black_pawn_row = squares[1]
    white_pawn_row = squares[6]

    (0...8).each do |column|
      black_pawn_row[column] = Piece.new(:black, :pawn)
      white_pawn_row[column] = Piece.new(:white, :pawn)
    end
  end

  def add_special_pieces
    pieces = [:rook, :knight, :bishop, :queen, :king, :bishop, :knight, :rook]
    black_special_piece_row = squares[0]
    white_special_piece_row = squares[7]

    (0...8).each do |column|
      black_special_piece_row[column] = Piece.new(:black, pieces[column])
      white_special_piece_row[column] = Piece.new(:white, pieces[column])
    end
  end

  # convenience method for now...
  def to_s
    num_squares = 8
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
# (0) 8 [♖] [♘] [♗] [♕] [♔] [♗] [♘] [♖]
# (1) 7 [♙] [♙] [♙] [♙] [♙] [♙] [♙] [♙]
# (2) 6 [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ]
# (3) 5 [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ]
# (4) 4 [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ]
# (5) 3 [ ] [ ] [ ] [ ] [ ] [ ] [ ] [ ]
# (6) 2 [♟︎] [♟︎] [♟︎] [♟︎] [♟︎] [♟︎] [♟︎] [♟︎]
# (7) 1 [♜] [♞] [♝] [♛] [♚] [♝] [♞] [♜]
#        a   b   c   d   e   f   g   h
#       (0) (1) (2) (3) (4) (5) (6) (7)
