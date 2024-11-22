# frozen_string_literal: true

require_relative './node'

# A class which constructs a binary search tree from an array
class Tree
  attr_reader :root

  def initialize(array = [])
    @root = build_tree(array)
  end

  def build_tree(array)
    array = sanitize_array(array)
    build_branches(array, start_index: 0, end_index: array.size - 1)
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
      ordered_tree << if block_given?
                        yield(node.value)
                      else
                        node.value
                      end
      queue.shift
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end

    ordered_tree
  end

  def inorder(node = @root, &block)
    inorder_tree = []
    return nil if node.nil?

    inorder_tree << inorder(node.left) unless node.left.nil?
    inorder_tree << node.value
    inorder_tree << inorder(node.right) unless node.right.nil?

    if block_given?
      inorder_tree.compact.flatten.map(&block)
    else
      inorder_tree.compact.flatten
    end
  end

  def preorder(node = @root, &block)
    preorder_tree = []
    return nil if node.nil?

    preorder_tree << node.value
    preorder_tree << preorder(node.left) unless node.left.nil?
    preorder_tree << preorder(node.right) unless node.right.nil?

    if block_given?
      preorder_tree.compact.flatten.map(&block)
    else
      preorder_tree.compact.flatten
    end
  end

  def postorder(node = @root, &block)
    postorder_tree = []
    return nil if node.nil?

    postorder_tree << postorder(node.left) unless node.left.nil?
    postorder_tree << postorder(node.right) unless node.right.nil?
    postorder_tree << node.value

    if block_given?
      postorder_tree.compact.flatten.map(&block)
    else
      postorder_tree.compact.flatten
    end
  end

  def height(node = @root)
    return 0 if node.nil?

    l_height = height(node.left)
    r_height = height(node.right)

    [l_height, r_height].max + 1
  end

  def depth(value, node = @root, depth = 0)
    case value <=> node.value
    when -1 then node.left = depth(value, node.left, depth + 1) unless node.left.nil?
    when  0 then depth
    when  1 then node.right = depth(value, node.right, depth + 1) unless node.right.nil?
    end
  end

  def balanced?
    l_tree_size = height(@root.left)
    r_tree_size = height(@root.right)

    (l_tree_size - r_tree_size).between?(0, 1)
  end

  def rebalance!
    initialize(inorder)
  end

  # Not mine -- The odin assignment provided this method
  def pretty_print(node = @root, prefix = '', left: true)
    pretty_print(node.right, "#{prefix}#{left ? '│   ' : '    '}", left: false) if node.right
    puts "#{prefix}#{left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{left ? '    ' : '│   '}", left: true) if node.left
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
