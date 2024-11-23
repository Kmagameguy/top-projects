# frozen_string_literal: true

require 'input'

RSpec.describe Input do
  describe '#initialize' do
    context 'when input does not contain a space' do
      it 'sets the first_location value' do
        allow_any_instance_of(described_class).to receive(:validate_input).and_return('a2a3')

        input = described_class.new
        expect(input.first_location).to eql 'a2'
      end

      it 'sets the second_location value' do
        allow_any_instance_of(described_class).to receive(:validate_input).and_return('a2a3')

        input = described_class.new
        expect(input.second_location).to eql 'a3'
      end
    end

    context 'when input contains a space' do
      it 'sets the first location value' do
        allow_any_instance_of(described_class).to receive(:validate_input).and_return('a2 a3')

        input = described_class.new
        expect(input.first_location).to eql 'a2'
      end

      it 'sets the second location value' do
        allow_any_instance_of(described_class).to receive(:validate_input).and_return('a2 a3')

        input = described_class.new
        expect(input.second_location).to eql 'a3'
      end
    end

    context 'when the input contains "quit game"' do
      before do
        allow_any_instance_of(described_class).to receive(:validate_input).and_return('quit game')
      end

      it 'sets the quit value' do
        input = described_class.new
        expect(input.quit).to be true
      end

      it 'sets first_location to nil' do
        input = described_class.new
        expect(input.first_location).to be_nil
      end

      it 'sets second_location to nil' do
        input = described_class.new
        expect(input.second_location).to be_nil
      end
    end
  end

  describe '#valid_name?' do
    context 'when the input is empty' do
      it 'returns false' do
        expect(described_class.valid_name?('')).to be false
      end
    end

    context 'when the input is any character' do
      it 'returns true' do
        expect(described_class.valid_name?('a')).to be true
      end
    end
  end

  describe '#yes_response?' do
    context 'when the input is "n"' do
      it 'returns false' do
        allow(described_class).to receive(:gets).and_return('n')

        input = described_class.yes_response?
        expect(input).to be false
      end
    end

    context 'when the input is "y"' do
      it 'returns true' do
        allow(described_class).to receive(:gets).and_return('y')

        input = described_class.yes_response?
        expect(input).to be true
      end
    end
  end

  describe '#valid_piece' do
    context 'when the selected piece is not a chess piece' do
      it 'returns false' do
        piece = 'Unidentified Flying Object'

        expect(described_class.valid_piece?(piece)).to be false
      end
    end

    context 'when the selected piece is not a valid chess piece' do
      it 'returns false' do
        piece = 'pawn'

        expect(described_class.valid_piece?(piece)).to be false
      end
    end

    context 'when the selected piece is a rook' do
      it 'returns true' do
        piece = 'rook'

        expect(described_class.valid_piece?(piece)).to be true
      end
    end

    context 'when the selected piece is a knight' do
      it 'returns true' do
        piece = 'knight'

        expect(described_class.valid_piece?(piece)).to be true
      end
    end

    context 'when the selected piece is a bishop' do
      it 'returns true' do
        piece = 'bishop'

        expect(described_class.valid_piece?(piece)).to be true
      end
    end

    context 'when the selected piece is a queen' do
      it 'returns true' do
        piece = 'queen'

        expect(described_class.valid_piece?(piece)).to be true
      end
    end
  end

  describe '#chess_notation?' do
    context 'when input does not match chess notation' do
      it 'rejects the input' do
        allow_any_instance_of(described_class).to receive(:validate_input).and_return('a2 a3')
        input = described_class.new

        invalid_input = 'fff'
        expect(input.chess_notation?(invalid_input)).to be false
      end
    end

    context 'when input does match chess notation' do
      it 'accepts the input' do
        allow_any_instance_of(described_class).to receive(:validate_input).and_return('a2 a3')
        input = described_class.new

        valid_input = 'a2 a3'
        expect(input.chess_notation?(valid_input)).to be true
      end
    end
  end
end
