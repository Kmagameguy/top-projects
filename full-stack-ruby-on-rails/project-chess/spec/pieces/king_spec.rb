# frozen_string_literal: true

require 'pieces/king'

RSpec.describe King do
  let(:board) { Array.new(8) { Array.new(8) } }

  describe '#possible_moves' do
    context 'when all squares are empty' do
      subject(:king) { described_class.new(:black, [3, 3]) }

      it 'returns one square in each diagonal and orthogonal direction from its current position' do
        expect(king.possible_moves(board).count).to eq 8
      end
    end

    context 'when some moves would place it off the board' do
      subject(:king) { described_class.new(:black, [0, 4]) }

      it 'only returns moves within the board space' do
        expect(king.possible_moves(board)).to match_array([[0, 3], [0, 5], [1, 3], [1, 4], [1, 5]])
      end
    end

    context 'when it is blocked by other pieces' do
      subject(:king) { described_class.new(:black, [0, 4]) }

      context 'and those pieces are its friends' do
        let(:other_piece) { Piece.new(:black, [0, 3]) }

        before do
          board[0][3] = other_piece
        end

        it 'returns moves that do not encroach on its friends' do
          expect(king.possible_moves(board)).to_not include([0, 3])
        end
      end

      context 'and those pieces are its enemies' do
        let(:enemy_piece) { Piece.new(:white, [0, 3]) }

        before do
          board[0][3] = enemy_piece
        end

        it 'includes attackable squares' do
          expect(king.possible_moves(board)).to include([0, 3])
        end
      end

      context 'and it is surrounded by friends' do
        before do
          friendly_squares = [[0, 3], [1, 3], [1, 4], [1, 5], [0, 5]]
          friendly_squares.each do |square|
            x, y = square
            board[x][y] = Piece.new(:black, square)
          end
        end

        it 'returns empty' do
          expect(king.possible_moves(board)).to be_empty
        end
      end
    end
  end

  describe '#trapped?' do
    subject(:king) { described_class.new(:black, [0, 4]) }

    context 'when it can move to a new square' do
      it 'returns false' do
        expect(king.trapped?(board)).to be false
      end
    end

    context 'when it is surrounded by friends' do
      surrounding_squares = [[0, 3], [1, 3], [1, 4], [1, 5], [0, 5]]

      before do
        surrounding_squares.each do |square|
          x, y = square
          board[x][y] = Piece.new(:black, square)
        end
      end

      it 'returns true' do
        expect(king.trapped?(board)).to be true
      end
    end

    context 'when it can escape by taking an enemy' do
      friendly_squares = [[0, 3], [1, 3], [1, 4], [1, 5]]
      enemy_square = [0, 5]

      before do
        friendly_squares.each do |square|
          x, y = square
          board[x][y] = Piece.new(:black, square)
        end

        board[enemy_square[0]][enemy_square[1]] = Piece.new(:white, enemy_square)
      end

      it 'returns false' do
        expect(king.trapped?(board)).to be false
      end
    end
  end

  describe '#to_s' do
    context 'when it is black' do
      subject(:black_king) { described_class.new(:black, [0, 4]) }

      it 'prints ♚' do
        expect(black_king.to_s).to eq '♚'
      end
    end

    context 'when it is white' do
      subject(:white_king) { described_class.new(:white, [7, 4]) }

      it 'prints ♔' do
        expect(white_king.to_s).to eq '♔'
      end
    end
  end
end
