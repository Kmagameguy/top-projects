# frozen_string_literal: true

require_relative '../movable'

# A generic playing piece
class Piece
  include Movable

  attr_reader :color, :type, :position

  def initialize(color, position)
    @color = color
    @position = position
    @moved = false
  end

  def move!(coordinates)
    @position = coordinates
    @moved = true
  end

  def moved?
    @moved
  end

  def white?
    color == :white
  end
end
