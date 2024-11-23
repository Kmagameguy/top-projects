# frozen_string_literal: true

require 'chess'

RSpec.describe Chess do
  subject(:game) { described_class.new('Freddy Krueger', 'Jason Voorhees') }

  before do
    allow_any_instance_of(Chess).to receive(:load_game?).and_return(false)
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
