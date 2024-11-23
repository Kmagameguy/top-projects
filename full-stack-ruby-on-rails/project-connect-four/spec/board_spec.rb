# frozen_string_literal: true

require 'board'

RSpec.describe Board do
  subject(:board) { Board.new }
  let(:player_marker) { 'x' }
  let(:computer_marker) { 'o' }
  let(:chosen_column) { 3 }


  describe '#find_slot' do
    it 'returns the value of the slot at the given coordinates' do
      board.slots[2][5] = player_marker
      expect(board.find_slot(3, 6)).to eql player_marker
    end
  end

  describe '#full?' do
    context 'when a column has chips in every slot' do
      it 'returns true' do
        6.times { board.drop_to_slot(chosen_column, player_marker) }
        expect(board.full?(chosen_column)).to be true
      end
    end

    context 'when a column does not have chips in every slot' do
      it 'returns false' do
        5.times { board.drop_to_slot(chosen_column, player_marker) }
        expect(board.full?(chosen_column)).to be false
      end
    end
  end

  describe '#drop_to_slot' do
    context 'when a chip is added to a column' do
      it 'puts the chip into the bottom-most slot' do
        bottom_row = board.row_count
        board.drop_to_slot(chosen_column, player_marker)
        expect(board.find_slot(bottom_row, chosen_column)).to eql player_marker
      end

      it 'keeps putting chips into the next-bottom-most slot' do
        bottom_row = board.row_count
        3.times { board.drop_to_slot(chosen_column, player_marker) }
        3.times do |index|
          expect(board.find_slot(bottom_row - index, chosen_column)).to eql player_marker
        end
        expect(board.find_slot(bottom_row - 4, chosen_column)).to be_nil
      end

      it "doesn't allow a player to overwrite an existing chip" do
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
        4.times do |index|
          marker_to_drop = index.even? ? player_marker : computer_marker
          board.drop_to_slot(chosen_column, marker_to_drop)
        end
        expect(board.any_in_a_row?(player_marker)).to be false
      end
    end

    context 'when a player has 4-in-a-row, vertically' do
      it 'returns true' do
        4.times { board.drop_to_slot(chosen_column, player_marker) }
        expect(board.any_in_a_row?(player_marker)).to be true
      end
    end

    context 'when a player has 4-in-a-row, horizontally' do
      it 'returns true' do
        4.times do |column|
          board.drop_to_slot(column + 1, player_marker)
        end
        expect(board.any_in_a_row?(player_marker)).to be true
      end
    end

    context 'when a player has 4-in-a-row, downslope' do
      it 'returns true' do
        4.times do |index|
          board.slots[index][index] = player_marker
        end

        expect(board.any_in_a_row?(player_marker)).to be true
      end
    end

    context 'when a player has 4-in-a-row, upslope' do
      it 'returns true' do
        board.slots[0][6] = player_marker
        board.slots[1][5] = player_marker
        board.slots[2][4] = player_marker
        board.slots[3][3] = player_marker

        expect(board.any_in_a_row?(player_marker)).to be true
      end
    end

    context 'when a player has 4 spots in a column, but not in-a-row' do
      it 'returns false' do
        3.times { board.drop_to_slot(chosen_column, player_marker) }
        board.drop_to_slot(chosen_column, computer_marker)
        board.drop_to_slot(chosen_column, player_marker)

        o_row = 3

        expect(board.find_slot(o_row, chosen_column)).to eql computer_marker
        expect(board.any_in_a_row?(player_marker)).to be false
      end
    end

    context 'when a player has 4 spots within a row, but not in-a-row' do
      it 'returns false' do
        game_row = [player_marker, nil, player_marker, player_marker, player_marker, nil]
        bottom_row = board.row_count - 1
        board.slots[bottom_row] = game_row

        expect(board.find_slot(6, 1)).to eql player_marker
        expect(board.any_in_a_row?(player_marker)).to be false
      end
    end

    context 'when a player has 4 spots upslope, but not in-a-row' do
      it 'returns false' do
        board.slots[5][0] = player_marker
        board.slots[4][1] = player_marker
        board.slots[3][2] = player_marker
        board.slots[1][4] = player_marker

        expect(board.any_in_a_row?(player_marker)).to be false
      end
    end

    context 'when a player has 4 spots downslope, but not in-a-row' do
      it 'returns false' do
        board.slots[0][6] = player_marker
        board.slots[1][5] = player_marker
        board.slots[2][4] = player_marker
        board.slots[4][4] = player_marker

        expect(board.any_in_a_row?(player_marker)).to be false
      end
    end
  end
end
