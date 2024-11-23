# frozen_string_literal: true

require 'board'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#setup_board' do
    piece_sequence = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    context 'when creating the black pieces' do
      rank7 = 1
      rank8 = 0

      it 'creates a rook, knight, bishop, queen, king, bishop, knight, rook at rank 8' do
        index = 0
        pieces_match_sequence = board.squares[rank8].all? do |piece|
          piece.is_a? piece_sequence[index]
          index += 1
        end

        expect(pieces_match_sequence).to be true
      end

      it 'ensures all pieces at rank 8 are black' do
        all_black = board.squares[rank8].all? { |piece| piece.color == :black }
        expect(all_black).to be true
      end

      it 'creates a set of pawns at rank 7' do
        all_pawns = board.squares[rank7].all? { |piece| piece.is_a? Pawn }
        expect(all_pawns).to be true
      end

      it 'ensures all pawns at rank 7 are black' do
        all_black = board.squares[rank7].all? { |piece| piece.color == :black }
        expect(all_black).to be true
      end
    end

    context 'when creating the white pieces' do
      rank1 = 7
      rank2 = 6

      it 'creates a rook, knight, bishop, queen, king, bishop, knight, rook at rank 1' do
        index = 0
        pieces_match_sequence = board.squares[rank1].all? do |piece|
          piece.is_a? piece_sequence[index]
          index += 1
        end

        expect(pieces_match_sequence).to be true
      end

      it 'ensures all pieces at rank 1 are white' do
        all_white = board.squares[rank1].all? { |piece| piece.color == :white }
        expect(all_white).to be true
      end

      it 'creates a set of pawns at rank 2' do
        all_pawns = board.squares[rank2].all? { |piece| piece.is_a? Pawn }
        expect(all_pawns).to be true
      end

      it 'ensures all pawns at rank 2 are white' do
        all_white = board.squares[rank2].all? { |piece| piece.color == :white }
        expect(all_white).to be true
      end
    end

    context 'when creating the rest of the board' do
      ranks3through6 = (2..5)

      it 'creates 8 empty squares in ranks 3 through 6' do
        empty = board.squares[ranks3through6].all? { |rank| rank.all?(&:nil?) }
        count8 = board.squares[ranks3through6].all? { |rank| rank.count == 8 }

        expect(empty).to be true
        expect(count8).to be true
      end
    end
  end

  describe '#square' do
    it 'returns nil if the square at the given coordinate is empty' do
      empty = board.square([2, 0])
      expect(empty).to be_nil
    end

    it 'returns a chess piece if one exists at the given coordinate' do
      pawn = board.square([1, 0])
      expect(pawn.is_a?(Pawn)).to be true
    end
  end

  describe '#update!' do
    before do
      starting_square = [1, 0]
      end_square = [2, 0]

      pawn = board.square(starting_square)
      board.update!(pawn, end_square)
    end

    it 'changes the position of the selected piece' do
      expect(board.square([2, 0]).is_a?(Pawn)).to be true
    end

    it 'sets the old square back to empty' do
      expect(board.square([1, 0])).to be_nil
    end
  end

  describe '#check?' do
    context 'when the king is not in check' do
      it 'returns false' do
        king_color = board.square([0, 4]).color
        attacker_color = :white

        expect(board.check?(king_color, attacker_color)).to be false
      end
    end

    context 'when the king is in check' do
      before do
        board.squares[6][4] = nil
        board.squares[6][5] = nil
        board.squares[1][7] = nil

        attacking_queen = board.square([0, 3])
        board.update!(attacking_queen, [4, 7])
      end

      it 'returns true' do
        king_color = board.square([7, 3]).color
        attacker_color = :black

        expect(board.check?(king_color, attacker_color)).to be true
      end
    end

    context 'when the king is in checkmate' do
      before do
        board.squares[6][5] = nil
        board.squares[1][4] = nil

        attacking_queen = board.square([0, 3])
        board.update!(attacking_queen, [4, 7])
      end

      it 'returns true' do
        king_color = board.square([7, 3]).color
        attacker_color = :black

        expect(board.check?(king_color, attacker_color)).to be true
      end
    end
  end

  describe '#find_king' do
    context 'when the black king has not moved' do
      it 'returns e8' do
        e8 = [0, 4]

        expect(board.find_king(:black)).to match_array(e8)
      end
    end

    context 'when the black king has moved to f6' do
      before do
        king_start_rank = 0
        king_start_file = 4
        f6 = [2, 5]

        black_king = board.square([king_start_rank, king_start_file])
        board.update!(black_king, f6)
      end
      it 'returns f6' do
        expect(board.find_king(:black)).to eq [2, 5]
      end
    end

    context 'when the white king has not moved' do
      it 'returns e7' do
        e7 = [7, 4]

        expect(board.find_king(:white)).to match_array(e7)
      end
    end

    context 'when the white king has moved to d3' do
      before do
        king_start_rank = 7
        king_start_file = 4
        d3 = [5, 3]

        white_king = board.square([king_start_rank, king_start_file])
        board.update!(white_king, d3)
      end

      it 'returns d3' do
        d3 = [5, 3]

        expect(board.find_king(:white)).to match_array(d3)
      end
    end
  end

  describe '#find_pieces' do
    color = :black
    context 'when no pieces have been taken' do
      it 'finds sixteen pieces' do
        pieces = board.find_pieces(color)
        expect(pieces.count).to be 16
      end

      it 'finds two rooks' do
        rooks = board.find_pieces(color).select { |piece| piece.is_a? Rook }
        expect(rooks.count).to be 2
      end

      it 'finds two knights' do
        knights = board.find_pieces(color).select { |piece| piece.is_a? Knight }
        expect(knights.count).to be 2
      end

      it 'finds two bishops' do
        bishops = board.find_pieces(color).select { |piece| piece.is_a? Bishop }
        expect(bishops.count).to be 2
      end

      it 'finds one queen' do
        queen = board.find_pieces(color).select { |piece| piece.is_a? Queen }
        expect(queen.count).to be 1
      end

      it 'finds one king' do
        king = board.find_pieces(color).select { |piece| piece.is_a? King }
        expect(king.count).to be 1
      end

      it 'finds eight pawns' do
        pawns = board.find_pieces(color).select { |piece| piece.is_a? Pawn }
        expect(pawns.count).to be 8
      end
    end

    context 'when some pieces have been taken' do
      before do
        # taken rook
        board.squares[0][0] = nil

        # taken queen
        board.squares[0][3] = nil

        # taken pawn
        board.squares[1][5] = nil
      end

      it 'finds the remaining pieces' do
        pieces = board.find_pieces(color)
        expect(pieces.count).to be 13
      end

      it 'finds the remaining rooks' do
        rooks = board.find_pieces(color).select { |piece| piece.is_a? Rook }
        expect(rooks.count).to be 1
      end

      it 'finds the remaining knights' do
        knights = board.find_pieces(color).select { |piece| piece.is_a? Knight }
        expect(knights.count).to be 2
      end

      it 'finds the remaining bishops' do
        bishops = board.find_pieces(color).select { |piece| piece.is_a? Bishop }
        expect(bishops.count).to be 2
      end

      it 'finds no queen' do
        queen = board.find_pieces(color).select { |piece| piece.is_a? Queen }
        expect(queen.count).to be 0
      end

      it 'finds one king' do
        king = board.find_pieces(color).select { |piece| piece.is_a? King }
        expect(king.count).to be 1
      end

      it 'finds the remaining pawns' do
        pawns = board.find_pieces(color).select { |piece| piece.is_a? Pawn }
        expect(pawns.count).to be 7
      end
    end
  end
end
