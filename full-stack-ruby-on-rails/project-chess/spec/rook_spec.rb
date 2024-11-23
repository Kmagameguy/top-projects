# frozen_string_literal: true

require 'pieces/rook'

RSpec.describe Rook do
  describe '#possible_moves' do
    let(:board) { Array.new(8) { Array.new(8) } }

    context 'when all squares are empty' do
      subject(:rook) { described_class.new(:black, [0, 3]) }

      it 'returns all squares which are orthogonal to its current position' do
        expect(rook.possible_moves(board)).to match_array([[0, 0], [0, 1], [0, 2], [0, 4], [0, 5], [0, 6], [0, 7], [1, 3], [2, 3], [3, 3], [4, 3], [5, 3], [6, 3], [7, 3]])
      end
    end

    context 'when it is blocked by other pieces' do
      subject(:rook) { described_class.new(:black, [0, 0]) }

      context 'and those pieces are its friends' do
        let(:other_piece) { Piece.new(:black, [1, 0]) }

        before do
          board[1][0] = other_piece
        end

        it 'returns moves that do not encroach on its friends' do
          expect(rook.possible_moves(board)).to match_array([[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]])
        end
      end

      context 'and those pieces are its enemies' do
        let(:enemy_piece) { Piece.new(:white, [2, 0]) }

        before do
          board[2][0] = enemy_piece
        end

        it 'includes the attackable squares' do
          expect(rook.possible_moves(board)).to include([2, 0])
        end

        it 'does not include squares which require passing through an enemy piece to reach' do
          expect(rook.possible_moves(board)).to_not include([3, 0])
        end
      end

      context 'and it is surrounded by friends' do
        before do
          friendly_squares = [[0, 1], [1, 0]]
          friendly_squares.each do |square|
            x, y = square
            board[x][y] = Piece.new(:black, square)
          end
        end

        it 'returns empty' do
          expect(rook.possible_moves(board)).to be_empty
        end
      end
    end
  end

  describe '#to_s' do
    context 'when it is black' do
      subject(:rook) { described_class.new(:black, [0, 0]) }

      it 'prints: ♜' do
        expect(rook.to_s).to eq '♜'
      end
    end
    context 'when it is white' do
      subject(:rook) { described_class.new(:white, [0, 0]) }

      it 'prints: ♖' do
        expect(rook.to_s).to eq '♖'
      end
    end
  end
end
