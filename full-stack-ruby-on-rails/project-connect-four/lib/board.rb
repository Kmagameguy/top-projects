# frozen_string_literal: true

# A class to manage our Connect Four game
class Board
  attr_accessor :slots

  def initialize
    @rows = 6
    @columns = 7
    @slots = Array.new(@rows) { Array.new(@columns) }
  end

  def size
    { rows: @rows, columns: @columns }
  end

  def find_slot(row, column)
    @slots[row - 1][column - 1]
  end
end
