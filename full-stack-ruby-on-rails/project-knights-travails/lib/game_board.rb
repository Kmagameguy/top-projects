# frozen_string_literal: true

require_relative 'knight'
require_relative 'node'
require 'pry-byebug'

# A class which contains a knight and a grid of positions onto which it can move
class GameBoard
  attr_accessor :knight

  def initialize(size: 8)
    @size = size
    @knight = Knight.new(board_size: @size)
  end
end

b = GameBoard.new
b.knight.coordinates = [1, 6]
puts "Starting position: #{b.knight.coordinates}"

# Board:
#
# [0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
# [1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
# [2, 0], [2, 1], [2, 2], [2, 3], [2, 4], [2, 5], [2, 6], [2, 7],
# [3, 0], [3, 1], [3, 2], [3, 3], [3, 4], [3, 5], [3, 6], [3, 7],
# [4, 0], [4, 1], [4, 2], [4, 3], [4, 4], [4, 5], [4, 6], [4, 7],
# [5, 0], [5, 1], [5, 2], [5, 3], [5, 4], [5, 5], [5, 6], [5, 7],
# [6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7],
# [7, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7]
#
# Look at Graphs... Dijkstra's Algorithm...
# As a game board, I:
# Have a grid of squares
# Have a knight
#
# Each square should be its own object, corresponding to an x,y coord
# Create a tree where the knight's starting position is the root
# Each child node is a potential move (but don't allow backtracking)
# Do a level_order traversal through the tree
# For each node, check if it is equal to the desired end position
# If not, check the next node
# If yes, use that node to store an array of the nodes connecting it to the root
