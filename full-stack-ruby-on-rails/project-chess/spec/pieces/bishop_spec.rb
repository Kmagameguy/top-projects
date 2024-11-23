# frozen_string_literal: true

require 'pieces/bishop'

RSpec.describe Bishop do
  let(:board) { Array.new(8) { Array.new(8) } }

  describe '#possible_moves' do
    context 'when all squares are empty' do
      subject(:bishop) { described_class.new(:black, [3, 3]) }

      it 'returns all squares which are diagonal to its current position' do
        expect(bishop.possible_moves(board).count).to eq 13
      end
    end

    context 'when some moves would place it off the board' do
      subject(:bishop) { described_class.new(:black, [0, 2]) }

      it 'only returns moves within the board space' do
        expect(bishop.possible_moves(board)).to match_array([[1, 1], [1, 3], [2, 0], [2, 4], [3, 5], [4, 6], [5, 7]])
      end
    end

    context 'when it is blocked by other pieces' do
      subject(:bishop) { described_class.new(:black, [0, 2]) }

      context 'and those pieces are its friends' do
        let(:other_bishop) { described_class.new(:black, [1, 1]) }

        before do
          board[1][1] = other_bishop
        end

        it 'returns moves that do not encroach on its friends' do
          expect(bishop.possible_moves(board)).to_not include([1, 1])
        end
      end

      context 'and those pieces are its enemies' do
        let(:other_bishop) { described_class.new(:white, [1, 1]) }

        before do
          board[1][1] = other_bishop
        end

        it 'includes attackable squares' do
          expect(bishop.possible_moves(board)).to include([1, 1])
        end

        it 'does not include squares beyond the enemy position' do
          expect(bishop.possible_moves(board)).to_not include([2, 0])
        end
      end

      context 'and it is surrounded by friends' do
        before do
          friendly_squares = [[1, 1], [1, 3]]
          friendly_squares.each do |square|
            x, y = square
            board[x][y] = Piece.new(:black, square)
          end
        end

        it 'returns empty' do
          expect(bishop.possible_moves(board)).to be_empty
        end
      end
    end
  end

  describe '#to_s' do
    context 'when it is black' do
      subject(:black_bishop) { described_class.new(:black, [0, 1]) }

      it 'prints: ♝' do
        expect(black_bishop.to_s).to eq '♝'
      end
    end

    context 'when it is white' do
      subject(:white_bishop) { described_class.new(:white, [0, 1]) }

      it 'prints: ♗' do
        expect(white_bishop.to_s).to eq '♗'
      end
    end
  end
end
