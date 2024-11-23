# frozen_string_literal: true

# A class to manage computer players
class Computer
  attr_reader :name, :marker

  def initialize(max_range = 7)
    @name = 'Computer'
    @marker = 'o'
    @max_range = max_range
  end

  def select_column
    (1..@max_range).to_a.sample
  end
end
