# frozen_string_literal: true

require 'chess'

RSpec.describe Chess do
  describe '#chess_notation_to_array_notation' do
    subject(:game) { described_class.new }

    context 'when input is lowercase' do
      it 'converts f8 to [0, 5]' do
        expect(game.chess_notation_to_array_notation('f8')).to eql [0, 5]
      end
    end

    context 'when input is uppercase' do
      it 'converts B8 to [0, 1]' do
        expect(game.chess_notation_to_array_notation('B8')).to eql [0, 1]
      end
    end

    context 'when input has trailing space' do
      it 'converts " C4  " to [4, 2]' do
        expect(game.chess_notation_to_array_notation(' C4  ')).to eql [4, 2]
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

      context 'when the move is blocked by another piece' do
        it 'returns false' do
          blocking_pawn = game.board.squares[1][0]
          moving_pawn = game.board.squares[6][0]

          game.board.update([1, 0], [4, 0])

          expect(game.valid_move?(moving_pawn, [4, 0])).to be false
        end
      end
    end
  end
end
