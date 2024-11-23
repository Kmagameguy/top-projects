# frozen_string_literal: true

require 'chess'

RSpec.describe Chess do
  describe '#chess_notation_to_array_notation' do
    subject(:game) { described_class.new }

    context 'when input is lowercase' do
      it 'converts f8 to [5, 8]' do
        expect(game.chess_notation_to_array_notation('f8')).to eql [5, 8]
      end
    end

    context 'when input is uppercase' do
      it 'converts B8 to [1, 8]' do
        expect(game.chess_notation_to_array_notation('B8')).to eql [1, 8]
      end
    end

    context 'when input has trailing space' do
      it 'converts " C4  " to [2, 4]' do
        expect(game.chess_notation_to_array_notation(' C4  ')).to eql [2, 4]
      end
    end
  end
end
