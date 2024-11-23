# frozen_string_literal: true

require_relative '../movable'

# A generic playing piece
class Piece
  include Movable

  attr_accessor :position
  attr_reader :color, :type

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

  def white?
    color == :white
  end
end
