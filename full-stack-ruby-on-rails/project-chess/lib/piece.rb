# frozen_string_literal: true

# A generic playing piece
class Piece
  attr_reader :color, :type

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
end
