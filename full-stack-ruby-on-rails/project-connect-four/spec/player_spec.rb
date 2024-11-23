# frozen_string_literal: true

require 'player'

RSpec.describe Player do
  subject(:column_selection) { described_class.new('Mannimarco', 'x') }

  describe 'picking a spot to drop a chip' do
    context 'when user selection is valid' do
      it 'stops loop and does not display error message' do
        valid_input = 2
        allow(column_selection).to receive(:user_input).and_return(valid_input)
        expect(column_selection).not_to receive(:puts).with('Input error!  Try again.')
        column_selection.select_column
      end
    end

    context 'when user selection is first invalid, then valid' do
      before do
        invalid_input = 0
        valid_input = 7
        allow(column_selection).to receive(:user_input).and_return(invalid_input, valid_input)
      end

      it 'displays an error message once' do
        expect(column_selection).to receive(:puts).with('Input error!  Try again.').once
        column_selection.select_column
      end
    end

    context 'when user input is incorrect several times before it is valid' do
      before do
        first_invalid_input = 0
        second_invalid_input = 13
        third_invalid_input = 1_000_000
        valid_input = 7
        allow(column_selection).to receive(:user_input).and_return(first_invalid_input, second_invalid_input, third_invalid_input, valid_input)
      end

      it 'shows errors until the valid input is entered' do
        expect(column_selection).to receive(:puts).with('Input error!  Try again.').thrice
        column_selection.select_column
      end
    end
  end
end
