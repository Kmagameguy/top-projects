# frozen_string_literal: true

# A generic playing piece
class Piece
  attr_accessor :position
  attr_reader :color, :type

  STRING_REPRESENTATION = {
    black: {
      king: '♚'
    },
    white: {
      king: '♔'
    }
  }

  def initialize(color, position)
    @color = color
    @position = position
    @moved = false
  end

  def moved?
    @moved
  end

  def move(coordinates)
    @position = coordinates
    @moved = true
  end

  def out_of_bounds?(move, board)
    move.any? { |coordinate| (coordinate.negative? || coordinate > board.size - 1) }
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

  def white?
    color == :white
  end
end
