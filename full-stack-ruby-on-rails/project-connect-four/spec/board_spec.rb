# frozen_string_literal: true

require 'board'

RSpec.describe Board do
  subject(:board) { Board.new }
  describe '#size' do
    it 'should have a grid size of 7x6 squares' do
      expect(board.size).to eq({ rows: 6, columns: 7 })
    end
  end

  describe '#find_slot' do
    it 'returns the value of the slot at the given coordinates' do
      board.slots[2][5] = 'x'
      expect(board.find_slot(3, 6)).to eql 'x'
    end
  end

  describe '#drop_to_slot' do
    context 'when a chip is added to a column' do
      it 'puts the chip into the bottom-most slot' do
        chosen_column = 3
        bottom_row = board.row_count
        player_marker = 'x'
        board.drop_to_slot(chosen_column, player_marker)
        expect(board.find_slot(bottom_row, chosen_column)).to eql player_marker
      end

      it 'keeps putting chips into the next-bottom-most slot' do
        chosen_column = 3
        player_marker = 'x'
        bottom_row = board.row_count

        3.times { board.drop_to_slot(chosen_column, player_marker) }

        3.times do |index|
          expect(board.find_slot(bottom_row - index, chosen_column)).to eql player_marker
        end

        expect(board.find_slot(bottom_row - 4, chosen_column)).to be_nil
      end

      it "doesn't allow a player to overwrite an existing chip" do
        chosen_column = 3
        player_marker = 'x'
        computer_marker = 'o'
        bottom_row = board.row_count

        board.drop_to_slot(chosen_column, player_marker)
        board.drop_to_slot(chosen_column, computer_marker)
        expect(board.find_slot(bottom_row, chosen_column)).to eql player_marker
      end
    end
  end
end
