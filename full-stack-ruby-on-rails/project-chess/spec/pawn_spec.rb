# frozen_string_literal: true

require 'pawn'

RSpec.describe Pawn do
  describe '#initialize' do
    subject(:pawn) { described_class.new(:black, [1, 0]) }

    it 'creates a black pawn at a7' do
      expect(pawn).to have_attributes(color: :black, position: [1, 0])
    end
  end

  describe '#possible_moves' do
    subject(:black_pawn) { described_class.new(:black, [1, 0]) }
    subject(:white_pawn) { described_class.new(:white, [6, 0]) }

    context 'when moving a pawn' do
      context 'and the pawn has not moved before' do
        it 'shows 2 possible moves' do
          expect(black_pawn.possible_moves).to eql [[3, 0], [2, 0]]
          expect(white_pawn.possible_moves).to eql [[4, 0], [5, 0]]
        end
      end

      context 'and the pawn has moved before' do
        it 'only shows 1 possible move' do
          black_position = [3, 0]
          white_position = [4, 0]

          black_pawn.move(black_position)
          white_pawn.move(white_position)

          expect(black_pawn.possible_moves).to eql [[4, 0]]
          expect(white_pawn.possible_moves).to eql [[3, 0]]
        end
      end
    end
  end
end
