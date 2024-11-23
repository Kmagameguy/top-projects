# frozen_string_literal: true

require 'chess'

RSpec.describe Chess do
  subject(:game) { described_class.new }

  before do
    allow_any_instance_of(Chess).to receive(:load_game?).and_return(false)
    allow_any_instance_of(Chess).to receive(:create_player).and_return('Freddy Krueger', 'Jason Voorhees')
  end

  describe '#switch_players' do
    it 'exchanges the active and inactive players' do
      expect(game.current_player.name).to eq 'Freddy Krueger'
      game.switch_players
      expect(game.current_player.name).to eq 'Jason Voorhees'
    end
  end

  describe '#other_player' do
    it 'returns the inactive player' do
      expect(game.current_player.name).to eq 'Freddy Krueger'
      expect(game.other_player.name).to eq 'Jason Voorhees'
    end
  end

  describe '#increment_round' do
    it 'adds 1 to the current turn_count' do
      expect(game.increment_round).to eq 2
    end
  end

  describe '#castling?' do
    context 'when the selected pieces are not a king and a rook' do
      it 'returns false' do
        first_piece = Piece.new(:black, [0, 0])
        second_piece = Rook.new(:black, [0, 1])

        expect(game.castling?(first_piece, second_piece)).to be false
      end
    end

    context 'when the selected pieces are a king and a rook' do
      it 'returns true' do
        first_piece = Rook.new(:black, [0, 0])
        second_piece = King.new(:black, [0, 4])

        expect(game.castling?(first_piece, second_piece)). to be true
      end
    end
  end

  describe '#identify_rook_and_king' do
    context 'when the rook is passed in first' do
      it 'returns [king, rook]' do
        rook = game.board.square([7, 0])
        king = game.board.square([7, 4])

        expect(game.identify_rook_and_king(rook, king)).to eql([king, rook])
      end
    end

    context 'when the king is passed in first' do
      it 'returns [king, rook]' do
        rook = game.board.square([7, 0])
        king = game.board.square([7, 4])

        expect(game.identify_rook_and_king(king, rook)).to eql([king, rook])
      end
    end
  end

  describe '#valid_castle?' do
    context 'when the spaces between the rook and the king are not empty' do
      it 'returns false' do
        rook = game.board.square([7, 0])
        king = game.board.square([7, 4])

        expect(game.valid_castle?(king, rook)).to be false
      end
    end

    context 'when some, but not all, the spaces between the rook and the king are empty' do
      before do
        2.times { |time| game.board.destroy_piece([7, time + 1]) }
      end

      it 'returns false' do
        rook = game.board.square([7, 0])
        king = game.board.square([7, 4])

        expect(game.valid_castle?(king, rook)).to be false
      end
    end

    context 'when the spaces between the rook and the king are empty' do
      before do
        3.times { |time| game.board.destroy_piece([7, time + 1]) }
      end

      context 'and the king is checked' do
        before do
          game.board.create_piece([5, 3], Knight, :black)
        end

        it 'returns false' do
          rook = game.board.square([7, 0])
          king = game.board.square([7, 4])

          expect(game.valid_castle?(king, rook)).to be false
        end
      end

      context 'and the king has moved' do
        it 'returns false' do
          rook = game.board.square([7, 0])
          king = game.board.square([7, 4])
          king.move!([7, 3])

          expect(game.valid_castle?(king, rook)).to be false
        end
      end

      context 'and the rook and king are different colors' do
        it 'returns false' do
          rook = game.board.square([0, 0])
          king = game.board.square([7, 4])

          expect(game.valid_castle?(king, rook)).to be false
        end
      end

      context 'and the king passes through a square which would put it into check' do
        before do
          game.board.create_piece([6, 2], Pawn, :black)
        end

        it 'returns false' do
          rook = game.board.square([0, 0])
          king = game.board.square([7, 4])

          expect(game.valid_castle?(king, rook)).to be false
        end
      end

      context 'and the rook and king can long-castle unimpeded' do
        it 'returns true' do
          rook = game.board.square([7, 0])
          king = game.board.square([7, 4])

          expect(game.valid_castle?(king, rook)).to be true
        end
      end

      context 'and the rook and king can short-castle unimpeded' do
        before do
          adjacent_right = 5
          2.times { |offset| game.board.destroy_piece([7, adjacent_right + offset]) }
        end

        it 'returns true' do
          rook = game.board.square([7, 7])
          king = game.board.square([7, 4])

          expect(game.valid_castle?(king, rook)).to be true
        end
      end
    end
  end

  describe '#castle!' do
    before do
      king_adjacent_right = 5
      3.times { |index| game.board.destroy_piece([7, index + 1]) }
      2.times { |offset| game.board.destroy_piece([7, king_adjacent_right + offset]) }
    end

    context 'when the rook is to the left of the king' do
      let(:rook) { game.board.square([7, 0]) }
      let(:king) { game.board.square([7, 4]) }

      before do
        game.castle!(king, rook)
      end

      it 'moves the king left two squares' do
        expect(king.position).to match_array([7, 2])
      end

      it "moves the rook to the king's right side" do
        expect(rook.position).to match_array([7, 3])
      end
    end

    context 'when the rook is to the right of the king' do
      let(:rook) { game.board.square([7, 7]) }
      let(:king) { game.board.square([7, 4]) }

      before do
        game.castle!(king, rook)
      end

      it 'moves the king right two squares' do
        expect(king.position).to match_array([7, 6])
      end

      it "moves the rook to the king's left side" do
        expect(rook.position).to match_array([7, 5])
      end
    end
  end

  describe '#valid?' do
    context 'when the selected piece can move to the destination' do
      it 'return true' do
        pawn = game.board.square([6, 0])
        destination = [5, 0]

        expect(game.current_player.color).to be :white
        expect(game.valid?(pawn, destination)).to be true
      end
    end

    context 'when the selected piece is not the right color' do
      it 'returns false' do
        black_piece = game.board.square([1, 0])
        destination = [2, 0]

        expect(game.current_player.color).to be :white
        expect(game.valid?(black_piece, destination)).to be false
      end
    end

    context 'when the selected piece cannot move' do
      it 'returns false' do
        rook = game.board.square([7, 0])
        destination = [6, 0]

        expect(game.current_player.color).to be :white
        expect(game.valid?(rook, destination)).to be false
      end
    end

    context "when the destination is not within the piece's move set" do
      it 'returns false' do
        pawn = game.board.square([6, 0])
        destination = [3, 0]

        expect(game.current_player.color).to be :white
        expect(game.valid?(pawn, destination)).to be false
      end
    end

    context 'when the destination would land on the opposing king' do
      before do
        white_pawn = game.board.square([6, 4])
        game.board.squares[1][4] = nil
        game.board.update!(white_pawn, [1, 4])
      end

      it 'returns false' do
        pawn = game.board.square([1, 4])
        king_square = game.board.square([0, 4])

        expect(pawn.position).to match_array([1, 4])
        expect(game.valid?(pawn, king_square)).to be false
      end
    end

    context 'when the destination would expose its own king to check' do
      before do
        black_queen = game.board.square([0, 3])
        game.board.update!(black_queen, [4, 7])
      end

      it 'returns false' do
        pawn = game.board.square([6, 5])
        destination = [5, 5]

        expect(game.valid?(pawn, destination)).to be false
      end
    end
  end

  describe '#game_over?' do
    context 'when the king is not under threat' do
      it 'returns false' do
        expect(game).to_not be_game_over
      end
    end

    context 'when the king is in check, but can escape' do
      before do
        # clear the way for the king & opposing queen
        game.board.squares[6][5] = nil
        game.board.squares[6][4] = nil
        game.board.squares[1][4] = nil

        queen = game.board.square([0, 3])
        game.board.update!(queen, [4, 7])
      end

      it 'returns false' do
        expect(game.current_player.color).to be :white
        expect(game).to_not be_game_over
      end
    end

    context 'when the king is in check, but another piece can defend' do
      before do
        game.board.squares[6][5] = nil
        game.board.squares[1][4] = nil

        queen = game.board.square([0, 3])
        game.board.update!(queen, [4, 7])
      end

      it 'returns false' do
        expect(game.current_player.color).to be :white
        expect(game).to_not be_game_over
      end
    end

    context 'when the king is doomed' do
      before do
        # set up "Fool's Mate"
        first_white_pawn = game.board.square([6, 5])
        second_white_pawn = game.board.square([6, 6])

        game.board.update!(first_white_pawn, [5, 5])
        game.board.update!(second_white_pawn, [4, 6])

        queen = game.board.square([0, 3])
        game.board.update!(queen, [4, 7])
      end

      it 'returns true' do
        expect(game.current_player.color).to be :white
        expect(game).to be_game_over
      end
    end
  end

  describe '#promote!' do
    before do
      game.switch_players
      game.board.create_piece([7, 0], Pawn, :black)
    end

    context 'when choosing to replace the pawn with a queen' do
      before do
        allow(game).to receive(:replacement_piece).and_return(Queen)
      end

      it 'converts the pawn into a queen' do
        b_pawn = game.board.square([7, 0])
        game.promote!(b_pawn)

        expect(game.board.square([7, 0])).to be_a Queen
      end
    end

    context 'when choosing to replace the pawn with a rook' do
      before do
        allow(game).to receive(:replacement_piece).and_return(Rook)
      end

      it 'converts the pawn into a queen' do
        b_pawn = game.board.square([7, 0])
        game.promote!(b_pawn)

        expect(game.board.square([7, 0])).to be_a Rook
      end
    end

    context 'when choosing to replace the pawn with a knight' do
      before do
        allow(game).to receive(:replacement_piece).and_return(Knight)
      end

      it 'converts the pawn into a knight' do
        b_pawn = game.board.square([7, 0])
        game.promote!(b_pawn)

        expect(game.board.square([7, 0])).to be_a Knight
      end
    end

    context 'when choosing to replace the pawn with a bishop' do
      before do
        allow(game).to receive(:replacement_piece).and_return(Bishop)
      end

      it 'converts the pawn into a bishop' do
        b_pawn = game.board.square([7, 0])
        game.promote!(b_pawn)

        expect(game.board.square([7, 0])).to be_a Bishop
      end
    end

    context 'when assigning a color to the replacement piece' do
      before do
        allow(game).to receive(:replacement_piece).and_return(Bishop)
      end

      it 'retains the original piece color' do
        b_pawn = game.board.square([7, 0])
        game.promote!(b_pawn)

        expect(game.board.square([7, 0]).color).to be :black
      end
    end
  end

  describe '#chess_notation_to_array' do
    context 'when input is lowercase' do
      it 'converts f8 to [0, 5]' do
        expect(game.chess_notation_to_array('f8')).to eql [0, 5]
      end
    end

    context 'when input is uppercase' do
      it 'converts B8 to [0, 1]' do
        expect(game.chess_notation_to_array('B8')).to eql [0, 1]
      end
    end

    context 'when input has trailing space' do
      it 'converts " C4  " to [4, 2]' do
        expect(game.chess_notation_to_array(' C4  ')).to eql [4, 2]
      end
    end
  end

  describe '#array_to_chess_notation' do
    it 'converts arrays to chess notation' do
      expect(game.array_to_chess_notation([0, 0])).to eq 'a8'
      expect(game.array_to_chess_notation([7, 7])).to eq 'h1'
      expect(game.array_to_chess_notation([3, 3])).to eq 'd5'
    end
  end
end
