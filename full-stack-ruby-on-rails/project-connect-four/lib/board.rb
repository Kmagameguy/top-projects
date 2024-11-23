# frozen_string_literal: true

# A class to manage our Connect Four game
class Board
  attr_reader :row_count, :column_count
  attr_accessor :slots

  def initialize
    @row_count = 6
    @column_count = 7
    @slots = Array.new(@row_count) { Array.new(@column_count) }
  end

  def size
    { rows: @row_count, columns: @column_count }
  end

  def drop_to_slot(column, marker)
    column_index = column - 1
    @slots.reverse_each do |row|
      if row[column_index].nil?
        row[column_index] = marker
        break
      end
    end
  end

  def find_slot(row, column)
    @slots[row - 1][column - 1]
  end
end
