# frozen_string_literal: true

require_relative 'knight'
require_relative 'node'
require 'pry-byebug'

# A class which contains a knight and a grid of positions onto which it can move
class GameBoard
  attr_accessor :knight, :visited_squares

  def initialize(size: 8)
    @size = size
    @knight = Knight.new(board_size: @size)
    @visited_squares = []
    @start_position = [0, 0]
    @end_position = [0, 0]
    @queue = []
  end

  def knight_move(source, destination)
    @start_position = source
    @end_position = destination
    build_move_tree(Node.new(coordinates: @start_position))
    print_result(find_shortest_path)
  end

  private

  def build_move_tree(path_node)
    @queue = [path_node]
    @visited_squares << path_node

    until @queue.empty?
      return if path_node.coordinates == @end_position

      enqueue_next_possible_moves(path_node)
      path_node = @queue.shift
    end
  end

  def enqueue_next_possible_moves(path_node)
    @knight.coordinates = path_node.coordinates
    @knight.possible_next_moves(@visited_squares).each do |p_move|
      next_path_node = Node.new(coordinates: p_move, parent: path_node)
      @queue << next_path_node
      @visited_squares << next_path_node
    end
  end

  def print_result(result)
    puts "Knight made it from #{result[:pathway].first} to #{result[:pathway].last} in #{result[:move_count]} moves."
    result[:pathway].each { |square| p square }
  end

  def find_shortest_path
    pathway = []
    move_count = 0
    node = destination_node

    until node.parent.nil?
      pathway << node.coordinates
      node = node.parent
      move_count += 1
    end

    pathway.append(@start_position).reverse!

    { move_count: move_count, pathway: pathway }
  end

  def destination_node
    @visited_squares.select { |square| square.coordinates == @end_position }
                    .first
  end
end

b = GameBoard.new
b.knight_move([3, 3], [4, 3])

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

#
# For each move...need to store the result and assign current iteration
# as the parent:
# So...[3, 4] would be parent of:
# [2, 2] AND [4, 2] AND [5, 3] AND [5, 5] AND [4, 6] AND [2, 6] AND [1, 5] AND [1, 3]
# then each of those would be parents of their spiderweb of hits:
# [2, 1] becomes parent of:
#   - [4, 0] AND [4, 2] AND [3, 3] AND [1, 3] AND [0, 2] AND [0, 0] NOT([3, 4])
# [0, 2] becomes parent of:
#   - [1, 0] AND [2, 1] AND [2, 3] AND [1, 4] NOT ([0, 2])
# [1, 4] becomes parent of:
#   - [0, 2] AND [2, 2] AND [3, 3] AND [3, 5] AND [2, 6] AND [0, 6]
# This also needs to track if a square has already been visited during an
# iteration to avoid hopping back-and-forth on a square
# We stop iterating when a move_set contains our desired destination
# So in this example, we would queue up:
# [3, 4]
# ask for possible next moves
# then queue up [2, 2], [4, 2], [5, 3], [5, 5], [4, 6], [2, 6], [1, 5], [1, 3]
# ask for possible next moves of [2, 2]
# then queue up [1, 0], [3, 0], [4, 1], [4, 3], [3, 4], [1, 4], [0, 3], [0, 1]

# DONE, [2, 6] is our destination
# Then we recall .parent() from dest until .parent() is nil to get our pathway
# So to iterate, each potential move needs to be loaded into a queue
#
