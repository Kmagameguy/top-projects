# frozen_string_literal: true

require_relative '../lib/node'

RSpec.describe Node do
  describe '#initialize' do
    it 'creates a new node with no parent' do
      node = described_class.new(coordinates: [3, 4])
      expect(node.parent).to be_nil
    end

    it 'creates a node with parent reference to another node' do
      root_node = described_class.new(coordinates: [3, 4])
      child_node = described_class.new(coordinates: [5, 5], parent: root_node)
      expect(child_node.parent).to be root_node
    end

    it 'creates a chain of linked nodes' do
      root_node = described_class.new(coordinates: [3, 4])
      child = described_class.new(coordinates: [5, 5], parent: root_node)
      grand_child = described_class.new(coordinates: [7, 7], parent: child)
      great_grand_child = described_class.new(coordinates: [6, 5], parent: grand_child)
      expect(great_grand_child.parent).to be grand_child
      expect(grand_child.parent).to be child
      expect(child.parent).to be root_node
      expect(root_node.parent).to be_nil
    end
  end
end
