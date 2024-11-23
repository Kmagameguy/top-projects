# frozen_string_literal: true

require 'board'

RSpec.describe Board do
  subject(:board) { Board.new }
  describe '#size' do
    it 'should have a grid size of 7x6 squares' do
      expect(board.size).to eq({ rows: 6, columns: 7})
    end
  end

  describe '#find_slot' do
    it 'returns the value of the slot at the given coordinates' do
      board.slots[2][5] = 'x'
      expect(board.find_slot(3, 6)).to eql 'x'
    end
  end
end
