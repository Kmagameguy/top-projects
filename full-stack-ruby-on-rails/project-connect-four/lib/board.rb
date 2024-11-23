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

  def drop_to_slot(column, chip)
    column_index = column - 1
    slots.reverse_each do |row|
      if row[column_index].nil?
        row[column_index] = chip
        break
      end
    end
  end

  def find_slot(row, column)
    slots[row - 1][column - 1]
  end

  def any_in_a_row?(chip)
    vertical_in_a_row?(chip) ||
      horizontal_in_a_row?(chip) ||
      upslope_in_a_row?(chip) ||
      downslope_in_a_row?(chip)
  end

  private

  def vertical_in_a_row?(chip)
    four_in_a_row?(slots, chip)
  end

  def horizontal_in_a_row?(chip)
    four_in_a_row?(rows_to_columns, chip)
  end

  def upslope_in_a_row?(chip)
    aligned_diagonals = vertically_align_diagonal_cells(check_upslope: true)
    four_in_a_row?(aligned_diagonals, chip)
  end

  def downslope_in_a_row?(chip)
    aligned_diagonals = vertically_align_diagonal_cells
    four_in_a_row?(aligned_diagonals, chip)
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

  def four_in_a_row?(rows, chip)
    chips_in_a_row = 0
    columns = rows[0].size
    columns.times do |column|
      chips_in_a_row = 0
      rows.each do |row|
        if row[column] == chip
          chips_in_a_row += 1
        else
          chips_in_a_row = 0
        end

        break if chips_in_a_row == 4
      end
      break if chips_in_a_row == 4
    end
    !!(chips_in_a_row == 4)
  end

  # I couldn't figure out a better way to avoid mutating the @slots
  # array when rotating its matrix of values.  .dup() and .clone() only
  # created shallow copies (per the spec) which meant any changes to rows
  # also mutated the original copy of the matrix, which was stored in @slots
  def deep_copy(arr)
    Marshal.load(Marshal.dump(arr))
  end
end
