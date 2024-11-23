# frozen_string_literal: true

# A player character
class Player
  attr_accessor :name, :moves
  attr_reader :marker

  def initialize(marker, name = 'Computer')
    @marker = marker
    @name = name
    @moves = []
  end

  def move(available_cells)
    loop do
      puts "#{@name}, make your move! Valid options are: #{available_cells}"

      selection = gets.chomp.to_s.to_i
      break selection if available_cells.include?(selection)

      puts 'Invalid input. Try again.'
    end
  end
end
