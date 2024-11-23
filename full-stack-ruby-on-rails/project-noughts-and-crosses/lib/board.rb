# frozen_string_literal: true

# A game board which displays the current open and marked cells to the player
class Board
  attr_accessor :board
  private :board

  def initialize(size)
    @board = Array.new(size, ' ')
    draw_board
  end

  def update_cells(move_list = [], marker = ' ')
    # Offset by 1 to map back from 1-indexed array to @board's 0-indexed array
    @board[move_list.last - 1] = marker unless move_list.empty?
    draw_board
  end

  def available_cells
    (1..@board.size).to_a - indexes_of_marked_cells
  end

  def blank?
    available_cells.count == @board.size
  end

  private

  def draw_board
    new_rows = [2, 5]
    clear_screen
    @board.each_with_index do |cell, index|
      draw_cell(cell)
      puts "\n" if new_rows.include?(index)
    end
    puts "\n\n"
  end

  def clear_screen
    system('clear')
    puts "\n"
  end

  def draw_cell(value)
    print "|#{value}|"
  end

  def indexes_of_marked_cells
    @board.map.with_index do |cell_value, cell_index|
      cell_index + 1 unless cell_value == ' '
    end.compact
  end
end
