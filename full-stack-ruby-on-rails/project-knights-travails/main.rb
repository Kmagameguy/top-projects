# frozen_string_literal: true

# This is just a driver script which calls our knight_moves method
# in demonstration of the algorithm.

require_relative './lib/game_board'

def random_coordinates
  Array.new(2) { rand(0..7) }
end

def print_results(r)
  puts "Knight made it from #{r[:pathway].first} to #{r[:pathway].last} in #{r[:move_count]} moves."
  r[:pathway].each { |square| p square }
  puts ''
end

b = GameBoard.new

10.times do
  r = b.knight_moves(random_coordinates, random_coordinates)
  print_results(r)
end
