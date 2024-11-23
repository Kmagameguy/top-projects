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

  describe '#any_in_a_row?' do
    context 'when no player has 4-in-a-row' do
      it 'returns false' do
        chosen_column = 3
        player_marker = 'x'
        computer_marker = 'o'

        4.times do |index|
          marker_to_drop = index.even? ? player_marker : computer_marker
          board.drop_to_slot(chosen_column, marker_to_drop)
        end

        expect(board.any_in_a_row?(player_marker)).to be false
      end
    end

    context 'when a player has 4-in-a-row, vertically' do
      it 'returns true' do
        chosen_column = 3
        player_marker = 'x'
        4.times { board.drop_to_slot(chosen_column, player_marker) }
        expect(board.any_in_a_row?(player_marker)).to be true
      end
    end

    context 'when a player has 4-in-a-row, horizontally' do
      it 'returns true' do
        player_marker = 'x'
        4.times do |column|
          board.drop_to_slot(column + 1, player_marker)
        end

        expect(board.any_in_a_row?(player_marker)).to be true
      end
    end

    context 'when a player has 4-in-a-row, downslope' do
      it 'returns true' do
        player_marker = 'x'

        board.slots[0][0] = player_marker
        board.slots[1][1] = player_marker
        board.slots[2][2] = player_marker
        board.slots[3][3] = player_marker

        expect(board.any_in_a_row?(player_marker)).to be true
      end
    end

    context 'when a player has 4-in-a-row, upslope' do
      it 'returns true' do
        player_marker = 'x'

        board.slots[0][6] = player_marker
        board.slots[1][5] = player_marker
        board.slots[2][4] = player_marker
        board.slots[3][3] = player_marker

        expect(board.any_in_a_row?(player_marker)).to be true
      end
    end

    context 'when a player has 4 spots in a column, but not in-a-row' do
      it 'returns false' do
        chosen_column = 3
        player_marker = 'x'
        computer_marker = 'o'

        3.times { board.drop_to_slot(chosen_column, player_marker) }
        board.drop_to_slot(chosen_column, computer_marker)
        board.drop_to_slot(chosen_column, player_marker)

        o_row = 3

        expect(board.find_slot(o_row, chosen_column)).to eql 'o'
        expect(board.any_in_a_row?('x')).to be false
      end
    end

    context 'when a player has 4 spots within a row, but not in-a-row' do
      it 'returns false' do
        game_row = ['x', nil, 'x', 'x', 'x', nil]
        bottom_row = board.row_count - 1
        board.slots[bottom_row] = game_row

        expect(board.find_slot(6, 1)).to eql 'x'
        expect(board.any_in_a_row?('x')).to be false
      end
    end

    context 'when a player has 4 spots upslope, but not in-a-row' do
      it 'returns false' do
        player_marker = 'x'

        board.slots[5][0] = player_marker
        board.slots[4][1] = player_marker
        board.slots[3][2] = player_marker
        board.slots[1][4] = player_marker

        expect(board.any_in_a_row?(player_marker)).to be false
      end
    end

    context 'when a player has 4 spots downslope, but not in-a-row' do
      it 'returns false' do
        player_marker = 'x'

        board.slots[0][6] = player_marker
        board.slots[1][5] = player_marker
        board.slots[2][4] = player_marker
        board.slots[4][4] = player_marker

        expect(board.any_in_a_row?(player_marker)).to be false
      end
    end
  end
end
