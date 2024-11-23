# frozen_string_literal: true

require 'player'

RSpec.describe Player do
  describe '#initialize' do
    subject(:player_one) { Player.new('Leon S. Kennedy', :black) }
    subject(:player_two) { Player.new('Jill Valentine', :white) }

    it 'has a name' do
      expect(player_one.name).to eql 'Leon S. Kennedy'
      expect(player_two.name).to eql 'Jill Valentine'
    end

    it 'is associated with a set of chess pieces' do
      expect(player_one.color).to be :black
      expect(player_two.color).to be :white
    end
  end
end
