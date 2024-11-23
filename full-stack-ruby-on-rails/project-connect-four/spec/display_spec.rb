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

    context 'when the row only has a player marker' do
      marker = '🔴'

      it 'shows a red marker' do
        board[0][0] = marker
        row = board[0]
        expect(display.emojify(row)).to eql '🔴 ⚪ ⚪ ⚪ ⚪ ⚪ ⚪'
      end
    end

    context 'when the row has a mix of taken and empty slots' do
      it 'shows the empty, player, and computer markers in the right spots' do
        player_marker = '🔴'
        computer_marker = '🔵'
        row = board[0]
        row[0] = player_marker
        row[3] = computer_marker
        row[4] = player_marker
        row[5] = player_marker

        expect(display.emojify(row)).to eql '🔴 ⚪ ⚪ 🔵 🔴 🔴 ⚪'
      end
    end
  end
end
