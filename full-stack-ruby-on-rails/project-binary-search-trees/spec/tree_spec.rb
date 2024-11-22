# frozen_string_literal: true

require_relative '../lib/tree'

RSpec.describe 'tree' do
  describe 'creating empty trees' do
    it 'creates an empty tree' do
      tree = Tree.new
      expect(tree.root).to be nil
    end
  end

  describe 'creating trees with values' do
    it 'creates a tree from simple values [1, 2, 3, 4, 5]' do
      tree = Tree.new([1,2,3,4,5])
      expect(tree.root.value).to be 3
    end

    it 'sorts and de-duplicates values before creating tree' do
      tree = Tree.new([5,2,1,3,4,1])
      expect(tree.root.value).to be 3
    end

    it 'creates a tree from complex values [1000, -30, 2, 22, 8, 15, -6]' do
      tree = Tree.new([1000, -30, 2, 22, 8, 15, -6])
      expect(tree.root.value).to be 8
    end
  end

  describe 'finding values in trees' do
    it 'returns nil if the tree is empty' do
      tree = Tree.new
      expect(tree.find(4)).to be nil
    end

    it 'returns the node if the value is found' do
      tree = Tree.new([1,2,3,4,5])
      expect(tree.find(4).value).to be 4
    end

    it 'returns nil if the value is not in the tree' do
      tree = Tree.new([1,2,3,4,5])
      expect(tree.find(100)).to be nil
    end
  end

  describe 'modifying nodes in trees' do
    it 'adds a value to the correct position' do
      tree = Tree.new([1,2,3,5])
      tree.insert(4)
      expect(tree.find(5).left.value).to be 4
      tree.insert(-30)
      expect(tree.find(1).left.value).to be -30
      tree.insert(1.5)
      expect(tree.find(1).right.value).to be 1.5
    end

    it 'removes a leaf node' do
      tree = Tree.new([1,2,3,4,5])
      expect(tree.find(4).value).to be 4
      tree.delete(4)
      expect(tree.find(5).left).to be nil
      expect(tree.find(5).right).to be nil
    end

    it 'removes a node and reshuffles any child nodes appropriately' do
      tree = Tree.new([1,2,3,4,5])
      expect(tree.find(3).value).to be 3
      tree.delete(3)
      expect(tree.root.value).to be 4
      expect(tree.root.left.value).to be 1
      expect(tree.root.right.value).to be 5
    end
  end

  describe 'returning the tree in level order' do
    it 'shows the level order of a tree' do
      tree = Tree.new([1,2,3,4,5])
      expect(tree.level_order).to eq [3, 1, 4, 2, 5]
    end

    it 'applies the given block to each value of the tree, in level order' do
      tree = Tree.new([1,2,3,4,5])
      modified_tree = tree.level_order { |node| node * 2 }
      expect(tree.level_order).to eq [3, 1, 4, 2, 5]
      expect(modified_tree).to eq [6, 2, 8, 4, 10]
    end
  end

  describe 'returning the tree in order' do
    it 'shows the ascending order of the tree' do
      tree = Tree.new([1,2,3,4,5])
      expect(tree.inorder).to eq [1, 2, 3, 4, 5]
    end

    it 'applies the given block to each value of the tree, in ascending order' do
      tree = Tree.new([1,2,3,4,5])
      modified_tree = tree.inorder { |node| node * 2 }
      expect(tree.inorder).to eq [1, 2, 3, 4, 5]
      expect(modified_tree).to eq [2, 4, 6, 8, 10]
    end
  end

  describe 'returning the tree in preorder' do
    it 'shows the preorder of the tree' do
      tree = Tree.new([1,2,3,4,5])
      expect(tree.preorder).to eq [3, 1, 2, 4, 5]
    end

    it 'applies the given block to each value of the tree, in preorder' do
      tree = Tree.new([1,2,3,4,5])
      modified_tree = tree.preorder { |node| node * 2 }
      expect(tree.preorder).to eq [3, 1, 2, 4, 5]
      expect(modified_tree).to eq [6, 2, 4, 8, 10]
    end
  end

  describe 'returning the tree in postorder' do
    it 'shows the postorder of the tree' do
      tree = Tree.new([1,2,3,4,5])
      expect(tree.postorder).to eq [2, 1, 5, 4, 3]
    end

    it 'applies the given block to each value of the tree, in postorder' do
      tree = Tree.new([1,2,3,4,5])
      modified_tree = tree.postorder { |node| node * 2 }
      expect(tree.postorder).to eq [2, 1, 5, 4, 3]
      expect(modified_tree).to eq [4, 2, 10, 8, 6]
    end
  end

  describe 'determining the height of a node' do
    it 'returns tree height if no node is specified' do
      tree = Tree.new([1,2,3,4,5])
      expect(tree.height).to be 3
    end

    it 'returns the height of the specified node' do
      tree = Tree.new([1,2,3,4,5])
      expect(tree.height(tree.find(5))).to be 1
    end
  end

  describe "determining a node's distance from root" do
    it 'returns 0 if the selected node is root' do
      tree = Tree.new([1,2,3,4,5])
      expect(tree.depth(3)).to be 0
    end

    it 'returns the correct depth for a selected node' do
      tree = Tree.new([1,2,3,4,5])
      expect(tree.depth(5)).to be 2
    end
  end

  describe 'determining whether a tree is balanced' do
    it 'returns true if the tree is balanced' do
      tree = Tree.new([1,2,3,4,5])
      expect(tree.balanced?).to be true
    end

    it 'returns false if the tree is unbalanced' do
      tree = Tree.new([1,2,3,4,5])
      tree.delete(4)
      tree.delete(5)
      expect(tree.balanced?).to be false
    end
  end
end
