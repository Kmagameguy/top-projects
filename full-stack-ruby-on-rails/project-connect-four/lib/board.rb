# frozen_string_literal: true

# A class to manage our Connect Four game
class Board
  def initialize
    @rows = 6
    @columns = 7
  end

  def size
    { rows: @rows, columns: @columns }
  end
end
