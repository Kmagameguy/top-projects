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

  # Not mine -- The odin assignment provided this method
  def pretty_print(node = @root, prefix = '', left = true)
    pretty_print(node.right, "#{prefix}#{left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{left ? '    ' : '│   '}", true) if node.left
  end

  private

  def sanitize_array(array)
    array.uniq!
    array.sort!
  end
end

array = [1, 2, 3, 4]
tree = Tree.new(array)
puts tree.pretty_print
print "\n\n-------\n\n"

array = [1, 2, 3, 4, 5, 6, 7]
tree = Tree.new(array)
puts tree.pretty_print
print "\n\n-------\n\n"

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(array)
puts tree.pretty_print
print "\n\n-------\n\n"

array = [1]
tree = Tree.new(array)
puts tree.pretty_print
print "\n\n-------\n\n"

array = [1, 1, 1, 2, 1, 1]
tree = Tree.new(array)
puts tree.pretty_print
print "\n\n-------\n\n"

array = [-200, 22, 100, 12, 74, -3, 12]
tree = Tree.new(array)
puts tree.pretty_print
print "\n\n-------\n\n"

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
