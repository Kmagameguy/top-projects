# frozen_string_literal: true

require_relative '../lib/knight'

RSpec.describe 'Knight' do
  describe 'creating Knights' do
    it 'creates a Knight at default coordinates' do
      k = Knight.new
      expect(k.coordinates).to eq [0, 0]
    end

    it 'creates a Knight at the coordinate [3, 5]' do
      k = Knight.new([3, 5])
      expect(k.coordinates).to eq [3, 5]
    end
  end

  describe 'moving the Knight' do
    it 'creates a clockwise 2d array of next-possible moves for the Knight' do
      k = Knight.new([3, 4])
      expect(k.possible_next_moves).to eq [[2, 2], [4, 2], [5, 3], [5, 5], [4, 6], [2, 6], [1, 5], [1, 3]]
    end

    it 'discards any moves that would place the Knight off the board' do
      k = Knight.new([0, 7])
      expect(k.possible_next_moves).to eq [[1, 5], [2, 6]]
    end

    it 'discards any moves which would introduce backtracking' do
      k = Knight.new([3, 4])
      k.visited_squares = [[3, 4], [2, 2]]
      expect(k.possible_next_moves).to eq [[4, 2], [5, 3], [5, 5], [4, 6], [2, 6], [1, 5], [1, 3]]
    end
  end
end
