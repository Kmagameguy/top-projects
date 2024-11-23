# frozen_string_literal: true

# A class to manage our Connect Four game
class Board
  attr_reader :row_count, :column_count
  attr_accessor :slots

  def initialize
    @row_count = 6
    @column_count = 7
    @slots = Array.new(row_count) { Array.new(column_count) }
  end

  def blank?
    slots.all? { |row| row.all?(&:nil?) }
  end

  def column_full?(column)
    column_index = column - 1

    slots.all? { |row| !row[column_index].nil? }
  end

  def full?
    slots.all? { |row| row.none?(&:nil?) }
  end

  def drop_to_slot(column, marker)
    column_index = column - 1
    slots.reverse_each do |row|
      if row[column_index].nil?
        row[column_index] = marker
        break
      end
    end
  end

  def find_slot(row, column)
    slots[row - 1][column - 1]
  end

  def any_in_a_row?(marker)
    vertical_in_a_row?(marker) ||
      horizontal_in_a_row?(marker) ||
      upslope_in_a_row?(marker) ||
      downslope_in_a_row?(marker)
  end

  private

  def vertical_in_a_row?(marker)
    four_in_a_row?(slots, marker)
  end

  def horizontal_in_a_row?(marker)
    four_in_a_row?(rows_to_columns, marker)
  end

  def upslope_in_a_row?(marker)
    aligned_diagonals = vertically_align_diagonal_cells(check_upslope: true)
    four_in_a_row?(aligned_diagonals, marker)
  end

  def downslope_in_a_row?(marker)
    aligned_diagonals = vertically_align_diagonal_cells
    four_in_a_row?(aligned_diagonals, marker)
  end

  def vertically_align_diagonal_cells(check_upslope: false)
    matrix = deep_copy(slots)
    matrix.reverse! if check_upslope
    matrix.map.with_index do |row, index|
      index.times do
        row.shift
        row.append(nil)
      end
    end
    matrix
  end

  def rows_to_columns
    deep_copy(slots).transpose
  end

  def four_in_a_row?(rows, marker)
    markers_in_a_row = 0
    columns = rows[0].size
    columns.times do |column|
      markers_in_a_row = 0
      rows.each do |row|
        if row[column] == marker
          markers_in_a_row += 1
        else
          markers_in_a_row = 0
        end

        break if markers_in_a_row == 4
      end
      break if markers_in_a_row == 4
    end
    !!(markers_in_a_row == 4)
  end

  # I couldn't figure out a better way to avoid mutating the @slots
  # array when rotating its matrix of values.  .dup() and .clone() only
  # created shallow copies (per the spec) which meant any changes to rows
  # also mutated the original copy of the matrix, which was stored in @slots
  def deep_copy(arr)
    Marshal.load(Marshal.dump(arr))
  end
end
