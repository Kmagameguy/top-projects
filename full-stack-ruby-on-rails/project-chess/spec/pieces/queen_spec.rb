# frozen_string_literal: true

require 'pieces/queen'

RSpec.describe Queen do
  let(:board) { Array.new(8) { Array.new(8) } }

  describe '#possible_moves' do
    context 'when all squares are empty' do
      subject(:queen) { described_class.new(:black, [3, 3]) }

      it 'returns all squares which are diagonal and orthogonal to its current position' do
        expect(queen.possible_moves(board).count).to eq 27
      end
    end

    context 'when some moves would place it off the board' do
      subject(:queen) { described_class.new(:black, [0, 3]) }

      it 'only returns moves within the board space' do
        expect(queen.possible_moves(board)).to match_array([[0, 0], [0, 1], [0, 2], [0, 4], [0, 5], [0, 6], [0, 7], [1, 2], [1, 3], [1, 4], [2, 1], [2, 3], [2, 5], [3, 0], [3, 3], [3, 6], [4, 3], [4, 7], [5, 3], [6, 3], [7, 3]])
      end
    end

    context 'when it is blocked by other pieces' do
      subject(:queen) { described_class.new(:black, [0, 3]) }

      context 'and those pieces are its friends' do
        let(:other_piece) { Piece.new(:black, [1, 3]) }

        before do
          board[1][3] = other_piece
        end

        it 'returns moves that do not encroach on its friends' do
          expect(queen.possible_moves(board)).to_not include([1, 3])
        end
      end

      context 'and those pieces are its enemies' do
        let(:enemy_piece) { Piece.new(:white, [1, 3]) }

        before do
          board[1][3] = enemy_piece
        end

        it 'includes attackable squares' do
          expect(queen.possible_moves(board)).to include([1, 3])
        end

        it 'does not include squares beyond the enemy position' do
          expect(queen.possible_moves(board)).to_not include([2, 3])
        end
      end

      context 'and it is surrounded by friends' do
        before do
          friendly_squares = [[0, 2], [1, 2], [1, 3], [1, 4], [0, 4]]
          friendly_squares.each do |square|
            x, y = square
            board[x][y] = Piece.new(:black, square)
          end
        end

        it 'returns empty' do
          expect(queen.possible_moves(board)).to be_empty
        end
      end
    end
  end

  describe '#trapped?' do
    subject(:queen) { described_class.new(:black, [0, 3]) }
    context 'when it can move to a new square' do
      it 'returns false' do
        expect(queen.trapped?(board)).to be false
      end
    end

    context 'when it is surrounded by friends' do
      surrounding_squares = [[0, 2], [1, 2], [1, 3], [1, 4], [0, 4]]

      before do
        surrounding_squares.each do |square|
          x, y = square
          board[x][y] = Piece.new(:black, square)
        end
      end

      it 'returns true' do
        expect(queen.trapped?(board)).to be true
      end
    end

    context 'when it is surrounded by enemies' do
      surrounding_squares = [[0, 2], [1, 2], [1, 3], [1, 4], [0, 4]]

      before do
        surrounding_squares.each do |square|
          x, y = square
          board[x][y] = Piece.new(:white, square)
        end
      end

      it 'returns false' do
        expect(queen.trapped?(board)).to be false
      end
    end
  end

  describe '#to_s' do
    context 'when it is black' do
      subject(:black_queen) { described_class.new(:black, [0, 3]) }

      it 'prints: ♛' do
        expect(black_queen.to_s).to eq '♛'
      end
    end

    context 'when it is white' do
      subject(:white_queen) { described_class.new(:white, [7, 3]) }

      it 'prints: ♕' do
        expect(white_queen.to_s).to eq '♕'
      end
    end
  end
end
