# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/noughts_and_crosses'

RSpec.describe Board do
  describe "#initialize" do
    subject(:new_game) { described_class.new(9) }
    it 'creates a new, empty playing board' do
      expect(new_game.available_cells.size).to be 9
    end
  end

  describe "#update_cells" do
    subject(:mid_game) { described_class.new(9) }

    context 'when a cell has been chosen' do
      it 'does nothing when the move list is empty' do
        player_move = []
        player_marker = 'x'
        mid_game.update_cells(player_move, player_marker)
        result = mid_game.instance_variable_get(:@board)
        expect(result).to eq [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      end

      it "marks the selected cell with the player's marker" do
        player_move = [5]
        player_marker = 'x'
        mid_game.update_cells(player_move, player_marker)
        result = mid_game.instance_variable_get(:@board)
        expect(result[4]).to eq player_marker
      end

      it "uses the latest move when provided a list of moves" do
        player_moves = [1, 3, 5]
        player_marker = 'o'
        mid_game.update_cells(player_moves, player_marker)
        result = mid_game.instance_variable_get(:@board)
        expect(result).to eq [" ", " ", " ", " ", "o", " ", " ", " ", " "]
      end
    end
  end

  describe '#available_cells' do
    subject(:mid_game) { described_class.new(9) }

    context 'when no cells have been chosen' do
      it 'returns all cells' do
        all_cells = Array.new(9) { |index| index + 1 }
        expect(mid_game.available_cells).to eq all_cells
      end
    end

    context 'when some cells have already been chosen' do
      it 'only shows available cells' do
        chosen_cells = ['x', ' ', 'o', ' ', '5', ' ', ' ', ' ', ' ']
        mid_game.instance_variable_set(:@board, chosen_cells)
        expect(mid_game.available_cells).to eq [2, 4, 6, 7, 8, 9]
      end
    end
  end

  describe '#blank?' do
    subject(:board) { described_class.new(9) }
    context 'when no cells have been chosen' do
      it 'returns true' do
        expect(board).to be_blank
      end
    end

    context 'when cells have been chosen' do
      it 'returns false' do
        chosen_cells = [' ', 'x', ' ', ' ', 'o', ' ', ' ', ' ', ' ']
        board.instance_variable_set(:@board, chosen_cells)
        expect(board).to_not be_blank
      end
    end
  end
end
