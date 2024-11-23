# frozen_string_literal: true

require 'board'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    it 'creates 8 rows' do
      row_count = board.squares.size
      expect(row_count).to be 8
    end

    it 'creates 8 columns' do
      column_count = board.squares.map { |row| row.size }.min
      expect(column_count).to be 8
    end
  end
end
