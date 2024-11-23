# frozen_string_literal: true

require_relative '../movable'

# A generic playing piece
class Piece
  include Movable

  attr_reader :color, :position

  def initialize(color, position)
    @color = color
    @position = position
    @moved = false
  end

  def possible_moves(board)
    []
  end

  def trapped?(board)
    possible_moves(board).empty?
  end

  def can_move?(board)
    !trapped?(board)
  end

  def move!(coordinates)
    @position = coordinates
    @moved = true
  end

  def moved?
    @moved
  end

  def not_moved?
    !moved?
  end

  def white?
    color == :white
  end
end
