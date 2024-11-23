# frozen_string_literal: true

# A class to manage players
class Player
  attr_reader :name, :marker

  def initialize(name, marker, max_range = 7)
    @name = name
    @marker = marker
    @max_range = max_range
  end

  def select_column
    loop do
      column = verify_input(user_input)
      return column if column

      puts 'Input error!  Try again.'
    end
  end

  private

  def verify_input(input)
    return input if input.between?(1, @max_range)
  end

  def user_input
    gets.chomp.to_i
  end
end
