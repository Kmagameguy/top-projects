# frozen_string_literal: true

require 'pieces/piece'

RSpec.describe Piece do
  describe '#initialize' do
    context 'when creating a piece' do
      subject(:black_piece) { described_class.new(:black, [0, 0]) }

      it 'knows its color' do
        expect(black_piece.color).to be :black
      end

      it 'knows its position' do
        expect(black_piece.position).to eql [0, 0]
      end

      it 'knows it has not yet moved' do
        expect(black_piece).to_not be_moved
      end
    end
  end

  describe '#move!' do
    subject(:piece) { described_class.new(:chartreuse, [0, 0]) }

    context 'when changing its position' do
      it 'Sets the new position' do
        piece.move!([0, 1])
        expect(piece.position).to eql [0, 1]
      end

      it 'Knows it has been moved' do
        piece.move!([0, 1])
        expect(piece).to be_moved
      end
    end
  end

  describe '#moved?' do
    subject(:piece) { described_class.new(:blurple, [0, 0]) }
    context 'when a piece is still in its home position' do
      it 'returns false' do
        expect(piece).to_not be_moved
      end
    end

    context 'when a piece has moved away from its home position' do
      it 'returns true' do
        piece.move!([0, 1])
        expect(piece).to be_moved
      end
    end
  end

  describe '#white?' do
    context 'when a piece is black' do
      subject(:black_piece) { described_class.new(:black, [0, 0]) }

      it 'returns false' do
        expect(black_piece).to_not be_white
      end
    end

    context 'when a piece is white' do
      subject(:white_piece) { described_class.new(:white, [0, 0]) }

      it 'returns true' do
        expect(white_piece).to be_white
      end
    end
  end
end
