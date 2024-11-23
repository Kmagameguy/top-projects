# frozen_string_literal: true

require 'display'

RSpec.describe Display do
  subject(:display) { described_class }
  let(:board) { Array.new(6) { Array.new(7) } }

  describe '#column_header' do
    it 'returns the header row' do
      expect(display.column_header).to eql " 1️⃣  2️⃣  3️⃣  4️⃣  5️⃣  6️⃣  7️⃣"
    end
  end

  describe '#emojify' do
    context 'when the row is empty' do
      it 'shows a blank row' do
        row = board[0]
        expect(display.emojify(row)).to eql '⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪'
      end
    end

    context 'when the row only has a player chip' do
      chip = '🔴'

      it 'shows a red chip' do
        board[0][0] = chip
        row = board[0]
        expect(display.emojify(row)).to eql '🔴 ⚪ ⚪ ⚪ ⚪ ⚪ ⚪'
      end
    end

    context 'when the row has a mix of taken and empty slots' do
      it 'shows the empty, player, and computer chips in the right spots' do
        player_chip = '🔴'
        computer_chip = '🔵'
        row = board[0]
        row[0] = player_chip
        row[3] = computer_chip
        row[4] = player_chip
        row[5] = player_chip

        expect(display.emojify(row)).to eql '🔴 ⚪ ⚪ 🔵 🔴 🔴 ⚪'
      end
    end
  end
end
