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
