# frozen_string_literal: true

require 'pieces/knight'

RSpec.describe Knight do
  let(:board) { Array.new(8) { Array.new(8) } }

  describe '#possible_moves' do
    context 'when all squares are empty' do
      subject(:knight) { described_class.new(:black, [3, 3]) }

      it 'returns eight moves' do
        expect(knight.possible_moves(board).count).to eql 8
      end
    end

    context 'when some moves would place it off the board' do
      subject(:knight) { described_class.new(:black, [0, 1]) }

      it 'only returns moves within the board space' do
        expect(knight.possible_moves(board)).to match_array([[1, 3], [2, 0], [2, 2]])
      end
    end

    context 'when it is blocked by other pieces' do
      subject(:knight) { described_class.new(:black, [0, 1]) }

      context 'and those pieces are its friends' do
        let(:other_knight) { described_class.new(:black, [2, 0]) }

        before do
          board[2][0] = other_knight
        end

        it 'returns moves that do not encroach on its friends' do
          expect(knight.possible_moves(board)).to_not include([2, 0])
        end
      end

      context 'and those pieces are its enemies' do
        let(:other_knight) { described_class.new(:white, [2, 0]) }

        before do
          board[2][0] = other_knight
        end

        it 'includes attackable squares' do
          expect(knight.possible_moves(board)).to include([2, 0])
        end
      end

      context 'and it is surrounded by friends' do
        before do
          friendly_squares = [[2, 0], [2, 2], [1, 3]]
          friendly_squares.each do |square|
            x, y = square
            board[x][y] = Piece.new(:black, square)
          end
        end

        it 'returns empty' do
          expect(knight.possible_moves(board)).to be_empty
        end
      end
    end
  end

  describe '#to_s' do
    context 'when it is black' do
      subject(:black_knight) { described_class.new(:black, [0, 1]) }

      it 'prints: ♞' do
        expect(black_knight.to_s).to eq '♞'
      end
    end

    context 'when it is white' do
      subject(:white_knight) { described_class.new(:white, [0, 1]) }

      it 'prints: ♘' do
        expect(white_knight.to_s).to eq '♘'
      end
    end
  end
end
