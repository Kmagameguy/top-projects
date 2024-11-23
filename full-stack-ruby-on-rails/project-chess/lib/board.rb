# frozen_string_literal: true

# A class to manage our chess board and its state
class Board
  attr_reader :squares

  def initialize
    @squares = Array.new(8) { Array.new(8) }
  end
end
