# frozen_string_literal: true

# A generic playing piece
class Piece
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

  def initialize(color, type)
    @color = color
    @type = type
    @moved = false
  end

  def moved?
    @moved
  end

  def move
    @moved = true
  end

  def to_s
    STRING_REPRESENTATION.dig(color, type)
  end
end
