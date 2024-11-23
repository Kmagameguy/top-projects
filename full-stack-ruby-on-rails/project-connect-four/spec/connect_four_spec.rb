# frozen_string_literal: true

require 'connect_four'

RSpec.describe ConnectFour do
  subject(:game_loop) { described_class.new(player_name: 'Ongar the World-Weary') }

  describe '#switch_players' do
    context 'when the game has just started' do
      it 'should make the user the active player' do
        expect(game_loop.current_player).to be game_loop.player
      end
    end

    context 'when the player has just taken a turn' do
      it 'should make the computer the active player' do
        game_loop.board.drop_to_slot(3, 'x')
        game_loop.switch_players
        expect(game_loop.current_player).to be game_loop.computer
      end
    end
  end

  describe '#pick_column' do
    context 'when user selection is valid' do
      it 'stops loop and does not display error message' do
        valid_input = 2
        allow(game_loop).to receive(:pick_column).and_return(valid_input)
        expect(game_loop).to_not receive(:puts).with('That column is full, try another.')
        game_loop.pick_column
      end
    end

    context 'when the selected column is full' do
      before do
        6.times { game_loop.board.drop_to_slot(3, game_loop.current_player.chip) }
        invalid_input = 3
        valid_input = 6
        allow(game_loop).to receive(:pick).and_return(invalid_input, valid_input)
      end

      it 'displays an error message once' do
        error_message = 'That column is full, try another.'
        expect(game_loop).to receive(:puts).with(error_message).once
        game_loop.pick_column
      end
    end
  end

  describe '#game_over?' do
    context 'when no player has 4-in-a-row' do
      it 'returns false' do
        expect(game_loop).to_not be_game_over
      end
    end

    context 'when a player has 4-in-a-row' do
      it 'returns true' do
        4.times { game_loop.board.drop_to_slot(3, game_loop.current_player.chip) }
        expect(game_loop).to be_game_over
      end
    end
  end
end
