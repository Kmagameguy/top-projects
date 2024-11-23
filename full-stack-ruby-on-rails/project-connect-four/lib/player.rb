# frozen_string_literal: true

# A class to manage players
class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end

  def select_column
    loop do
      column = verify_input(pick_spot)
      break if column

      puts 'Input error!  Try again.'
    end
  end

  private

  def verify_input(input)
    return input if input.between?(1, 7)
  end

  def pick_spot
    puts "#{name}, it's your turn.  Next move?"
    puts 'Available options: 1, 2, 3, 4, 5, 6, 7'
    gets.chomp.to_i
  end
end
