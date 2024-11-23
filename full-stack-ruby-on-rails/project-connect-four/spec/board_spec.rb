# frozen_string_literal: true

require 'board'

RSpec.describe Board do
  subject(:board) { Board.new }
  describe '#size' do
    it 'should have a grid size of 7x6 squares' do
      expect(board.size).to eq({ rows: 6, columns: 7})
    end
  end
end
