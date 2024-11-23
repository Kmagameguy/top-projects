# frozen_string_literal: true

# A computer character with alternative guessing methods
class Computer < Player
  def move(available_cells)
    available_cells.sample
  end
end
