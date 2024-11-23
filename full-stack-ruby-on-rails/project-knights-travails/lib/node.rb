# frozen_string_literal: true

# A class to manage knight movement over a board
class Node
  attr_accessor :coordinates, :parent

  def initialize(coordinates:, parent: nil)
    @coordinates = coordinates
    @parent = parent
  end
end
