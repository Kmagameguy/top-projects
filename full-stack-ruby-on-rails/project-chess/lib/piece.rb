# frozen_string_literal: true

# A generic playing piece
class Piece
  attr_accessor :position
  attr_reader :color, :type

  STRING_REPRESENTATION = {
    black: {
      pawn: '♟︎',
      knight: '♞',
      bishop: '♝',
      rook: '♜',
      queen: '♛',
      king: '♚'
    },
    white: {
      pawn: '♙',
      knight: '♘',
      bishop: '♗',
      rook: '♖',
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

  def to_s
    STRING_REPRESENTATION.dig(color, type)
  end
end
