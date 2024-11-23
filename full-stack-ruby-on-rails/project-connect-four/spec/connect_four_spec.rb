# frozen_string_literal: true

require 'connect_four'

RSpec.describe ConnectFour do
  subject(:game_loop) { described_class.new(player_name: 'Ongar the World-Weary', player_marker: 'x') }

  describe 'adding a chip to the board' do
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
        6.times { game_loop.board.drop_to_slot(3, game_loop.current_player.marker) }
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
end
