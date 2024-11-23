# frozen_string_literal: true

require 'pieces/pawn'

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
    let(:board) { Array.new(8) { Array.new(8) } }

    context 'when moving a pawn' do
      context 'and the pawn has not moved before' do
        context "and the pawn's path is clear" do
          it 'shows 2 possible moves' do
            expect(black_pawn.possible_moves(board)).to match_array([[3, 0], [2, 0]])
            expect(white_pawn.possible_moves(board)).to match_array([[4, 0], [5, 0]])
          end
        end

        context 'and the rushable square is blocked' do
          before do
            black_blocking_piece = Piece.new(:black, [3, 0])
            white_blocking_piece = Piece.new(:white, [4, 0])

            board[3][0] = black_blocking_piece
            board[4][0] = white_blocking_piece
          end

          it 'shows one possible move' do
            expect(black_pawn.possible_moves(board)).to match_array([[2, 0]])
            expect(white_pawn.possible_moves(board)).to match_array([[5, 0]])
          end
        end

        context "and the pawn's immediate path is blocked" do
          before do
            black_blocking_piece = Piece.new(:black, [2, 0])
            white_blocking_piece = Piece.new(:white, [5, 0])

            board[2][0] = black_blocking_piece
            board[5][0] = white_blocking_piece
          end

          it 'returns empty' do
            expect(black_pawn.possible_moves(board)).to be_empty
            expect(white_pawn.possible_moves(board)).to be_empty
          end
        end
      end

      context 'and the pawn has moved before' do
        context "and the pawn's path is clear" do
          before do
            black_position = [3, 0]
            white_position = [4, 2]

            black_pawn.move!(black_position)
            white_pawn.move!(white_position)

            board[3][0] = black_pawn
            board[4][2] = white_pawn
          end

          it 'only shows 1 possible move' do
            expect(black_pawn.possible_moves(board)).to match_array([[4, 0]])
            expect(white_pawn.possible_moves(board)).to match_array([[3, 2]])
          end
        end

        context 'and the pawn can attack' do
          before do
            black_position = [3, 0]
            white_position = [4, 1]

            black_pawn.move!(black_position)
            white_pawn.move!(white_position)

            board[3][0] = black_pawn
            board[4][1] = white_pawn
          end

          it 'includes an attacking diagonal move' do
            expect(black_pawn.possible_moves(board)).to include([4, 1])
          end
        end

        context 'and the pawn is blocked by its friend' do
          let(:other_black_pawn) { described_class.new(:black, [4, 0]) }
          let(:other_white_pawn) { described_class.new(:white, [3, 2]) }

          before do
            black_position = [3, 0]
            white_position = [4, 2]

            black_pawn.move!(black_position)
            white_pawn.move!(white_position)

            board[3][0] = black_pawn
            board[4][2] = white_pawn
            board[4][0] = other_black_pawn
            board[3][2] = other_white_pawn
          end

          it 'returns empty' do
            expect(black_pawn.possible_moves(board)).to be_empty
            expect(white_pawn.possible_moves(board)).to be_empty
          end
        end

        context 'and the pawn is blocked by an enemy' do
          let(:other_black_pawn) { described_class.new(:black, [4, 0]) }
          let(:other_white_pawn) { described_class.new(:white, [3, 2]) }

          before do
            black_position = [3, 0]
            white_position = [4, 2]

            black_pawn.move!(black_position)
            white_pawn.move!(white_position)

            board[3][0] = black_pawn
            board[4][2] = white_pawn
            board[4][0] = other_black_pawn
            board[3][2] = other_white_pawn
          end

          it 'returns empty' do
            expect(black_pawn.possible_moves(board)).to be_empty
            expect(white_pawn.possible_moves(board)).to be_empty
          end
        end

        context 'and no moves are possible' do
          before do
            black_position = [7, 0]
            white_position = [0, 0]

            black_pawn.move!(black_position)
            white_pawn.move!(white_position)

            board[7][0] = black_pawn
            board[0][0] = white_pawn
          end

          it 'returns empty' do
            expect(black_pawn.possible_moves(board)).to be_empty
            expect(white_pawn.possible_moves(board)).to be_empty
          end
        end
      end
    end
  end

  describe '#trapped?' do
    let(:board) { Array.new(8) { Array.new(8) } }
    subject(:pawn) { described_class.new(:black, [1, 0]) }

    context 'when it can move to a new square' do
      it 'returns false' do
        expect(pawn.trapped?(board)).to be false
      end
    end

    context 'when it is blocked by a friend' do
      before do
        board[2][0] = Piece.new(:black, [2, 0])
      end

      it 'returns true' do
        expect(pawn.trapped?(board)).to be true
      end
    end

    context 'when it is blocked by an enemy' do
      before do
        board[2][0] = Piece.new(:white, [2, 0])
      end

      it 'returns true' do
        expect(pawn.trapped?(board)).to be true
      end
    end

    context 'when it is blocked by another piece but can move by attacking' do
      before do
        board[2][0] = Piece.new(:white, [2, 0])
        board[2][1] = Piece.new(:white, [2, 1])
      end

      it 'returns false' do
        expect(pawn.trapped?(board)).to be false
      end
    end
  end

  describe '#promote?' do
    let(:board) { Array.new(8) { Array.new(8) } }

    subject(:black_pawn) { described_class.new(:black, [1, 0]) }
    subject(:white_pawn) { described_class.new(:white, [6, 0]) }

    context 'when the pawns have not moved' do
      it 'returns false' do
        expect(black_pawn).to_not be_promote
        expect(white_pawn).to_not be_promote
      end
    end

    context 'when the pawns have moved but not reached their opposing side' do
      before do
        black_pawn.move!([3, 0])
        white_pawn.move!([4, 0])
      end

      it 'returns false' do
        expect(black_pawn).to_not be_promote
        expect(white_pawn).to_not be_promote
      end
    end

    context 'when the pawns have reached their opposing side' do
      before do
        black_pawn.move!([7, 0])
        white_pawn.move!([0, 0])
      end

      it 'returns true' do
        expect(black_pawn).to be_promote
        expect(white_pawn).to be_promote
      end
    end
  end

  describe '#to_s' do
    context 'when it is black' do
      subject(:black_pawn) { described_class.new(:black, [0, 0]) }

      it 'prints: ♟︎' do
        expect(black_pawn.to_s).to eq '♟︎'
      end
    end

    context 'when it is white' do
      subject(:white_pawn) { described_class.new(:white, [0, 0]) }
      it 'prints: ♙' do
        expect(white_pawn.to_s).to eq '♙'
      end
    end
  end
end
