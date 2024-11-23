# frozen_string_literal: true

require 'piece'

RSpec.describe Piece do
  describe '#intialize' do
    context 'when creating black pieces' do
      let(:color) { :black }

      it 'creates a pawn' do
        type = :pawn

        pawn = described_class.new(color, type)
        expect(pawn).to have_attributes(color: :black, type: :pawn)
      end

      it 'creates a bishop' do
        type = :bishop

        bishop = described_class.new(color, type)
        expect(bishop).to have_attributes(color: :black, type: :bishop)
      end

      it 'creates a knight' do
        type = :knight

        knight = described_class.new(color, type)
        expect(knight).to have_attributes(color: :black, type: :knight)
      end

      it 'creates a rook' do
        type = :rook

        rook = described_class.new(color, type)
        expect(rook).to have_attributes(color: :black, type: :rook)
      end

      it 'creates a queen' do
        type = :queen

        queen = described_class.new(color, type)
        expect(queen).to have_attributes(color: :black, type: :queen)
      end

      it 'creates a king' do
        type = :king

        king = described_class.new(color, type)
        expect(king).to have_attributes(color: :black, type: :king)
      end
    end

    context 'when creating white pieces' do
      let(:color) { :white }

      it 'creates a pawn' do
        type = :pawn

        pawn = described_class.new(color, type)
        expect(pawn).to have_attributes(color: :white, type: :pawn)
      end

      it 'creates a bishop' do
        type = :bishop

        bishop = described_class.new(color, type)
        expect(bishop).to have_attributes(color: :white, type: :bishop)
      end

      it 'creates a knight' do
        type = :knight

        knight = described_class.new(color, type)
        expect(knight).to have_attributes(color: :white, type: :knight)
      end

      it 'creates a rook' do
        type = :rook

        rook = described_class.new(color, type)
        expect(rook).to have_attributes(color: :white, type: :rook)
      end

      it 'creates a queen' do
        type = :queen

        queen = described_class.new(color, type)
        expect(queen).to have_attributes(color: :white, type: :queen)
      end

      it 'creates a king' do
        type = :king

        king = described_class.new(color, type)
        expect(king).to have_attributes(color: :white, type: :king)
      end
    end
  end
end
