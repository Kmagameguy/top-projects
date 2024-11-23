# frozen_string_literal: true

require_relative '../lib/noughts_and_crosses'

RSpec.describe NoughtsAndCrossesGame do
  describe "#change_players" do
    subject(:game_round) { described_class.new('Carl') }

    context 'when it is a new game' do
      it 'the player goes first' do
        player = game_round.instance_variable_get(:@player)
        current_player = game_round.instance_variable_get(:@current_player)
        expect(current_player).to be player
      end
    end

    context 'when it is a new round' do
      it 'changes the active player' do
        computer = game_round.instance_variable_get(:@computer)
        expect(game_round.change_players).to be computer
      end
    end
  end

  describe '#game_over?' do
    context 'when neither player has three-in-a-row' do
      subject(:game_round) { described_class.new('Carl') }
      it 'returns false' do
        expect(game_round).to_not be_game_over
      end
    end

    context 'when the player has three-in-a-row' do
      subject(:player_win) { described_class.new('Carl') }
      it 'returns true' do
        player = player_win.instance_variable_get(:@player)
        player.moves = [1, 2, 3]
        expect(player_win).to be_game_over
      end
    end

    context 'when the computer has three-in-a-row' do
      subject(:computer_win) { described_class.new('Carl') }
      it 'returns true' do
        computer_win.change_players
        computer = computer_win.instance_variable_get(:@computer)
        computer.moves = [4, 5, 6]
        expect(computer_win).to be_game_over
      end
    end

    context 'when all cells are filled but neither player has three-in-a-row' do
      subject(:scratch_game) { described_class.new('Carl') }

      it 'returns true' do
        player = scratch_game.instance_variable_get(:@player)
        computer = scratch_game.instance_variable_get(:@computer)
        board = scratch_game.instance_variable_get(:@board)
        game_moves = ['x', 'x', 'o', 'o', 'o', 'x', 'x', 'o', 'x']
        board.instance_variable_set(:@board, game_moves)

        expect(scratch_game).to be_game_over
      end
    end
  end
end
