# frozen_string_literal: true

require_relative './node'

# A class which constructs a binary search tree from an array
class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    # Guard against non-arrays and single values masquerading as arrays
    return array if !array.is_a?(Array) || array.size < 2

    # Return level-0 root node
    sanitize_array(array)
  end

  private

  def sanitize_array(array)
    array.uniq!
    array.sort!
  end
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
p Tree.new(array)

array = [1]
p Tree.new(array)

array = [1, 1, 1, 2, 1, 1]
p Tree.new(array)

array = [-200, 22, 100, 12, 74, -3, 12]
p Tree.new(array)
