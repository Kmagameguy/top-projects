# frozen_string_literal: true

require 'computer'

RSpec.describe Computer do
  describe '#select_column' do
    context 'when the max_range is a default value of 7' do
      subject(:computer) { described_class.new }

      it 'picks a number between 1 and 7' do
        max_range = 7
        100.times { expect(computer.select_column).to be_between(1, max_range) }
      end
    end

    context 'when the max_range is a modified value of 3' do
      subject(:non_default_computer) { described_class.new(3) }

      it 'picks a number between 1 and 3' do
        max_range = 3
        100.times { expect(non_default_computer.select_column).to be_between(1, max_range) }
      end
    end
  end
end
