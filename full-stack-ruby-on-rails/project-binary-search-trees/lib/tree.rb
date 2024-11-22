# frozen_string_literal: true

require_relative './node'

# A class which constructs a binary search tree from an array
class Tree
  attr_reader :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    # Return level-0 root node
    array = sanitize_array(array)
    build_branches(array, start_index: 0, end_index: array.size-1)
  end

  def build_branches(array, start_index:, end_index:)
    return nil if start_index > end_index

    mid_point = (start_index + end_index) / 2

    root = Node.new(array[mid_point])
    root.left = build_branches(array,
                               start_index: start_index,
                               end_index: mid_point - 1)

    root.right = build_branches(array,
                                start_index: mid_point + 1,
                                end_index: end_index)

    root
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    case value <=> node.value
    when -1 then node.left = insert(value, node.left)
    when  0 then return node
    when  1 then node.right = insert(value, node.right)
    end

    node
  end

  def delete(value, node = @root)
    return node if node.nil?

    case value <=> node.value
    when -1 then node.left = delete(value, node.left)
    when  1 then node.right = delete(value, node.right)
    when  0
      if only_one_child?(node)
        new_node = node.left.nil? ? node.right : node.left
        node = nil
        return new_node
      end

      node.value = find_min_value(node.right)
      node.right = delete(node.value, node.right)
    end

    node
  end

  def find(value, node = @root)
    return nil if node.nil?

    case value <=> node.value
    when -1 then node.left = find(value, node.left)
    when  0 then node
    when  1 then node.right = find(value, node.right)
    end
  end

  def level_order
    ordered_tree = []
    queue = []
    return ordered_tree unless @root

    queue << @root

    until queue.empty?
      node = queue[0]
      ordered_tree << node.value
      queue.shift
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end

    ordered_tree
  end

  def inorder(node = @root)
    inorder_tree = []
    return nil if node.nil?

    inorder_tree << inorder(node.left) unless node.left.nil?
    inorder_tree << node.value
    inorder_tree << inorder(node.right) unless node.right.nil?

    inorder_tree.compact.flatten
  end

  def preorder(node = @root)
    preorder_tree = []
    return nil if node.nil?

    preorder_tree << node.value
    preorder_tree << preorder(node.left) unless node.left.nil?
    preorder_tree << preorder(node.right) unless node.right.nil?

    preorder_tree.compact.flatten
  end

  def postorder(node = @root)
    postorder_tree = []
    return nil if node.nil?

    postorder_tree << postorder(node.left) unless node.left.nil?
    postorder_tree << postorder(node.right) unless node.right.nil?
    postorder_tree << node.value

    postorder_tree.compact.flatten
  end

  # Not mine -- The odin assignment provided this method
  def pretty_print(node = @root, prefix = '', left = true)
    pretty_print(node.right, "#{prefix}#{left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{left ? '    ' : '│   '}", true) if node.left
  end

  private

  def only_one_child?(node)
    node.left.nil? || node.right.nil?
  end

  def find_min_value(node)
    current = node
    current = current.left until current.left.nil?
    current.value
  end

  def sanitize_array(array)
    array.uniq!
    array.sort!
  end
end

array = [1, 2, 3, 4, 5]
tree = Tree.new(array)
puts tree.pretty_print
p tree.level_order
p tree.inorder
p tree.preorder
p tree.postorder
# array = [1, 2, 3, 5]
# tree = Tree.new(array)
# puts tree.pretty_print
# print "\n\n-------\n\n"

# tree.insert(4)
# puts tree.pretty_print
# print "\n\n-------\n\n"

# tree.delete(3)
# puts tree.pretty_print
# print "\n\n-------\n\n"

# tree.delete(2)
# puts tree.pretty_print
# print "\n\n-------\n\n"

# tree.insert(7)
# puts tree.pretty_print
# print "\n\n-------\n\n"

# p tree.find(5)
# print "\n\n-------\n\n"

# array = [1, 2, 3, 4, 5, 6, 7]
# tree = Tree.new(array)
# puts tree.pretty_print
# print "\n\n-------\n\n"

# array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
# tree = Tree.new(array)
# puts tree.pretty_print
# print "\n\n-------\n\n"

# array = [1]
# tree = Tree.new(array)
# puts tree.pretty_print
# print "\n\n-------\n\n"

# array = [1, 1, 1, 2, 1, 1]
# tree = Tree.new(array)
# puts tree.pretty_print
# print "\n\n-------\n\n"

# array = [-200, 22, 100, 12, 74, -3, 12]
# tree = Tree.new(array)
# puts tree.pretty_print
# print "\n\n-------\n\n"

# Initialize start = 0, end = length of array - 1
# mid = (start + end) / 2
# Create node with mid as root

# left_subtree = start..mid
#   l_mid = l_start + l_end / 2
#   l_left_subtree = l_start..l_mid
#   l_right_subtree = l_mid..l_end
#      ...
# right_subtree = mid..end
#   r_mid = r_start + r_end / 2
#   l_right_subtree = r_start..r_mid
#   r_right_subtree = r_mid..r_end
