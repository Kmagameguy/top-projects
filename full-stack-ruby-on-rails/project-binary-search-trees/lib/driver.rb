# frozen_string_literal: true

require_relative './tree'

# Context: Per The Odin Project Assignment:
# Write a simple driver script that does the following:

# 1. Create a binary search tree from an array of random numbers
# 2. Confirm that the tree is balanced by calling #balanced?
# 3. Print out all elements in level, pre, post, and in order
# 4. Unbalance the tree by adding several numbers > 100
# 5. Confirm that the tree is unbalanced by calling #balanced?
# 6. Balance the tree by calling #rebalance
# 7. Confirm that the tree is balanced by calling #balanced?
# 8. Print out all elements in level, pre, post, and in order

# The course hasn't covered unit tests yet so I assume they wanted us to create
# this script to test the functionality of our Tree and Node classes.
# I'm going through these motions for the sake of completeness.
# Otherwise, see the included tree_spec.rb for tests that cover the features
# of this project.

array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)
puts ''
puts "Source array: #{array}"
puts 'Here is your tree:'
puts tree.pretty_print
puts "Is the tree balanced?: #{tree.balanced?}"
puts "\n\n-------\n\n"

puts "Tree in Level Order: #{tree.level_order}"
puts "Tree in Pre-Order: #{tree.preorder}"
puts "Tree in Post-Order: #{tree.postorder}"
puts "Tree in Ascending Order: #{tree.inorder}"
puts "\n\n-------\n\n"

puts 'Unbalance the Tree'
tree.tap { |t| 4.times { t.insert(rand(101..200)) } }
puts tree.pretty_print
puts "Is the tree balanced now?: #{tree.balanced?}"
puts "\n\n-------\n\n"

puts 'Rebalance the Tree'
tree.rebalance!
puts tree.pretty_print
puts "Is the tree balanced after calling #rebalance! ?: #{tree.balanced?}"
puts "\n\n-------\n\n"

puts "Tree's new Level Order: #{tree.level_order}"
puts "Tree's new Pre-Order: #{tree.preorder}"
puts "Tree's new Post-Order: #{tree.postorder}"
puts "Tree's new Ascending Order: #{tree.inorder}"
