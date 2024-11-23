# frozen_string_literal: true

require_relative '../lib/knight'
require_relative '../lib/node'

RSpec.describe Knight do
  describe '#initialize' do
    it 'creates a Knight at default coordinates' do
      k = described_class.new
      expect(k.coordinates).to eq [0, 0]
    end

    it 'creates a Knight at the coordinate [3, 5]' do
      k = described_class.new(starting_position: [3, 5])
      expect(k.coordinates).to eq [3, 5]
    end
  end

  describe '#possible_next_moves' do
    it 'creates a clockwise 2d array of next-possible moves for the Knight' do
      k = described_class.new(starting_position: [3, 4])
      expect(k.possible_next_moves([])).to eq [[2, 2], [4, 2], [5, 3], [5, 5], [4, 6], [2, 6], [1, 5], [1, 3]]
    end

    it 'discards any moves that would place the Knight off the board' do
      k = described_class.new(starting_position: [0, 7])
      expect(k.possible_next_moves([])).to eq [[1, 5], [2, 6]]
    end

    it 'discards any moves which would introduce backtracking' do
      k = described_class.new(starting_position: [3, 4])
      node1 = Node.new(coordinates: [3, 4])
      node2 = Node.new(coordinates: [4, 2])
      node3 = Node.new(coordinates: [5, 3])
      visited_squares = [node1, node2, node3]
      expect(k.possible_next_moves(visited_squares)).to eq [[2, 2], [5, 5], [4, 6], [2, 6], [1, 5], [1, 3]]
    end
  end
end
