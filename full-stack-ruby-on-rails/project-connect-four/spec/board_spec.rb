# frozen_string_literal: true

require 'board'
require 'display'

RSpec.describe Board do
  subject(:board) { Board.new }
  let(:player_chip) { '🔴' }
  let(:computer_chip) { '🔵' }
  let(:chosen_column) { 3 }

  describe '#blank?' do
    context 'when no one has played a move yet' do
      it 'returns true' do
        expect(board).to be_blank
      end
    end

    context 'when at least one player has made a move' do
      it 'returns false' do
        board.slots[0][0] = player_chip
        expect(board).to_not be_blank
      end
    end
  end

  describe '#find_slot' do
    it 'returns the value of the slot at the given coordinates' do
      board.slots[2][5] = player_chip
      expect(board.find_slot(3, 6)).to eql player_chip
    end
  end

  describe '#column_full?' do
    context 'when a column has chips in every slot' do
      it 'returns true' do
        6.times { board.drop_to_slot(chosen_column, player_chip) }
        expect(board.column_full?(chosen_column)).to be true
      end
    end

    context 'when a column does not have chips in every slot' do
      it 'returns false' do
        5.times { board.drop_to_slot(chosen_column, player_chip) }
        expect(board.column_full?(chosen_column)).to be false
      end
    end
  end

  describe '#full?' do
    context 'when all slots are filled' do
      it 'returns true' do
        board.slots.each { |row| row.map! { player_chip } }

        expect(board).to be_full
      end
    end

    context 'when board is blank' do
      it 'returns false' do
        expect(board).to_not be_full
      end
    end

    context 'when some slots are still available' do
      it 'returns false' do
        board.drop_to_slot(chosen_column, player_chip)
        expect(board).to_not be_full
      end
    end
  end

  describe '#drop_to_slot' do
    context 'when a chip is added to a column' do
      it 'puts the chip into the bottom-most slot' do
        bottom_row = board.row_count
        board.drop_to_slot(chosen_column, player_chip)
        expect(board.find_slot(bottom_row, chosen_column)).to eql player_chip
      end

      it 'keeps putting chips into the next-bottom-most slot' do
        bottom_row = board.row_count
        3.times { board.drop_to_slot(chosen_column, player_chip) }
        3.times do |index|
          expect(board.find_slot(bottom_row - index, chosen_column)).to eql player_chip
        end
        expect(board.find_slot(bottom_row - 4, chosen_column)).to be_nil
      end

      it "doesn't allow a player to overwrite an existing chip" do
        bottom_row = board.row_count

        board.drop_to_slot(chosen_column, player_chip)
        board.drop_to_slot(chosen_column, computer_chip)
        expect(board.find_slot(bottom_row, chosen_column)).to eql player_chip
      end
    end
  end

  describe '#any_in_a_row?' do
    context 'when no player has 4-in-a-row' do
      it 'returns false' do
        4.times do |index|
          chip_to_drop = index.even? ? player_chip : computer_chip
          board.drop_to_slot(chosen_column, chip_to_drop)
        end
        expect(board.any_in_a_row?(player_chip)).to be false
      end
    end

    context 'when a player has 4-in-a-row, vertically' do
      it 'returns true' do
        4.times { board.drop_to_slot(chosen_column, player_chip) }
        expect(board.any_in_a_row?(player_chip)).to be true
      end
    end

    context 'when a player has 4-in-a-row, horizontally' do
      it 'returns true' do
        4.times do |column|
          board.drop_to_slot(column + 1, player_chip)
        end
        expect(board.any_in_a_row?(player_chip)).to be true
      end
    end

    context 'when a player has 4-in-a-row, downslope' do
      it 'returns true' do
        4.times do |index|
          board.slots[index][index] = player_chip
        end

        expect(board.any_in_a_row?(player_chip)).to be true
      end
    end

    context 'when a player has 4-in-a-row, upslope' do
      it 'returns true' do
        board.slots[0][6] = player_chip
        board.slots[1][5] = player_chip
        board.slots[2][4] = player_chip
        board.slots[3][3] = player_chip

        expect(board.any_in_a_row?(player_chip)).to be true
      end
    end

    context 'when a player has 4 spots in a column, but not in-a-row' do
      it 'returns false' do
        3.times { board.drop_to_slot(chosen_column, player_chip) }
        board.drop_to_slot(chosen_column, computer_chip)
        board.drop_to_slot(chosen_column, player_chip)

        o_row = 3

        expect(board.find_slot(o_row, chosen_column)).to eql computer_chip
        expect(board.any_in_a_row?(player_chip)).to be false
      end
    end

    context 'when a player has 4 spots within a row, but not in-a-row' do
      it 'returns false' do
        game_row = [player_chip, nil, player_chip, player_chip, player_chip, nil, nil]
        bottom_row = board.row_count - 1
        board.slots[bottom_row] = game_row

        expect(board.find_slot(6, 1)).to eql player_chip
        expect(board.any_in_a_row?(player_chip)).to be false
      end
    end

    context 'when a player has 4 spots upslope, but not in-a-row' do
      it 'returns false' do
        board.slots[5][0] = player_chip
        board.slots[4][1] = player_chip
        board.slots[3][2] = player_chip
        board.slots[1][4] = player_chip

        expect(board.any_in_a_row?(player_chip)).to be false
      end
    end

    context 'when a player has 4 spots downslope, but not in-a-row' do
      it 'returns false' do
        board.slots[0][6] = player_chip
        board.slots[1][5] = player_chip
        board.slots[2][4] = player_chip
        board.slots[4][4] = player_chip

        expect(board.any_in_a_row?(player_chip)).to be false
      end
    end

    context 'when a player has a chip in the last slot of a row and three chips in the following rows first three slots' do
      it 'returns false' do
        board.slots[5][0] = player_chip
        board.slots[5][1] = player_chip
        board.slots[5][2] = player_chip
        board.slots[3][3] = player_chip
        board.slots[5][4] = player_chip
        board.slots[5][5] = player_chip
        board.slots[4][6] = player_chip

        expect(board.any_in_a_row?(player_chip)).to be false
      end
    end
  end
end
