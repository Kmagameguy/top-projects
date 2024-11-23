# frozen_string_literal: true

require_relative '../lib/game_board.rb'

RSpec.describe "Knight's Travails Game Board" do
  describe 'routing the Knight' do
    it 'moves the Knight from source to destination in least number of steps' do
      b = GameBoard.new

      k = b.knight_moves([0, 0], [1, 2])
      expected_path = [[0, 0], [1, 2]]
      expected_move_count = expected_path.size - 1

      expect(k[:move_count]).to eq expected_move_count
      expect(k[:move_count] + 1).to eq k[:pathway].length
      expect(k[:pathway]).to eq expected_path

      k = b.knight_moves([0, 0], [3, 3])
      expected_path = [[0, 0], [2, 1], [3, 3]]
      expected_move_count = expected_path.size - 1

      expect(k[:move_count]).to eq expected_move_count
      expect(k[:move_count] + 1).to eq k[:pathway].length
      expect(k[:pathway]).to eq expected_path

      k = b.knight_moves([3, 3], [4, 3])
      expected_path = [[3, 3], [4, 1], [6, 2], [4, 3]]
      expected_move_count = expected_path.size - 1

      expect(k[:move_count]).to eq expected_move_count
      expect(k[:move_count] + 1).to eq k[:pathway].length
      expect(k[:pathway]).to eq expected_path
    end
  end
end
