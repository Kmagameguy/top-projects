# frozen_string_literal: true

# A generic playing piece
class Piece
  attr_accessor :position
  attr_reader :color, :type

  STRING_REPRESENTATION = {
    black: {
      knight: '♞',
      bishop: '♝',
      queen: '♛',
      king: '♚'
    },
    white: {
      knight: '♘',
      bishop: '♗',
      queen: '♕',
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

  def white?
    color == :white
  end

  def to_s
    STRING_REPRESENTATION.dig(color, type)
  end
end
