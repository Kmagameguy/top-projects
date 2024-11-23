# frozen_string_literal: true

require_relative '../lib/game_board.rb'

RSpec.describe GameBoard do
  before(:all) do
    @b = described_class.new
  end
  describe '#knight_moves' do
    it 'moves the Knight from source to destination' do
      k = @b.knight_moves([0, 0], [1, 2])
      expect(k[:pathway].first).to eq [0, 0]
      expect(k[:pathway].last).to eq [1, 2]
    end

    it 'moves the Knight using the least number of steps' do
      k = @b.knight_moves([0, 0], [1, 2])
      expected_path = [[0, 0], [1, 2]]
      expected_move_count = (expected_path.size - 1)
      expect(k[:move_count]).to eq(expected_move_count)
    end

    it 'moves the Knight the least amount of times across a long path' do
      k = @b.knight_moves([3, 3], [4, 3])
      expected_path = [[3, 3], [4, 1], [6, 2], [4, 3]]
      expected_move_count = (expected_path.size - 1)
      expect(k[:move_count]).to eq expected_move_count
      expect(k[:move_count]).to eq k[:pathway].length - 1
      expect(k[:pathway]).to eq expected_path
    end
  end
end
