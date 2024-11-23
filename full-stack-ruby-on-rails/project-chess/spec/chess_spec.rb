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

  describe '#valid_move?' do
    subject(:game) { described_class.new }

    context 'when the piece is a pawn' do
      context 'and the move is valid' do
        it 'returns true' do
          pawn = game.board.squares[1][0]
          expect(game.valid_move?(pawn, [2, 0])).to be true
        end
      end

      context 'and the move is out of bounds' do
        it 'returns false' do
          pawn = game.board.squares[1][0]
          pawn.move([7, 0])
          expect(game.valid_move?(pawn, [8, 0])).to be false
        end
      end
    end
  end
end
