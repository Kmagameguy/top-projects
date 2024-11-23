# frozen_string_literal: true

require_relative 'knight'
require_relative 'node'

# A class which contains a knight and a grid of positions onto which it can move
class GameBoard
  def initialize(size: 8)
    @size = size
    @knight = Knight.new(board_size: @size)
    @visited_squares = []
    @start_position = [0, 0]
    @end_position = [0, 0]
    @queue = []
  end

  def knight_moves(source, destination)
    @start_position = source
    @end_position = destination
    build_move_tree(@start_position)
    find_shortest_path
  end

  private

  def build_move_tree(coordinates)
    path_node = Node.new(coordinates: coordinates)
    @queue = [path_node]
    @visited_squares = [path_node]

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
