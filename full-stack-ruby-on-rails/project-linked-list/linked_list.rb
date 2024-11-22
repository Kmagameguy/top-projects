# frozen_string_literal: true

require './node'

# A class to manage relationships between nodes
class LinkedList
  attr_reader :head

  def initialize
    @head = nil
  end

  def prefix(value)
    if @head.nil?
      @head = Node.new(value)
    else
      current_head = @head
      @head = Node.new(value, current_head)
    end
  end

  def append(value)
    if @head.nil?
      @head = Node.new(value)
    else
      find_tail.next_node = Node.new(value)
    end
  end

  def size
    return 0 if @head.nil?

    counter = 1
    reference = @head

    while reference.next_node
      counter += 1
      reference = reference.next_node
    end
    counter
  end

  def at(index)
    return @head if index.zero?

    counter = 0
    reference = @head

    while reference.next_node
      return reference if counter == index

      counter += 1
      reference = reference.next_node
    end
    reference
  end

  def pop
    return if @head.nil?

    counter = 0
    index = (self.size - 2)
    new_tail = @head
    while new_tail.next_node
      break if counter == index

      counter += 1
      new_tail = new_tail.next_node
    end

    new_tail.next_node = nil
    new_tail
  end

  def contains?(value)
    return false if @head.nil?

    reference = @head
    match = false

    loop do
      match = reference.data == value

      break if match || reference.next_node.nil?

      reference = reference.next_node
    end

    match
  end

  def find(value)
    return nil if @head.nil?

    reference = @head
    counter = 0
    index = nil

    while reference.next_node
      index = counter if reference.data == value
      break if reference.data == value

      reference = reference.next_node
      counter += 1
    end

    index
  end

  def find_tail
    current_node = @head
    current_node = current_node.next_node while current_node.next_node
    current_node
  end
end

list = LinkedList.new
list.append(10)
list.append(20)
list.append(30)
list.prefix(100)

p list
p list.size
p list.at(3).data
p list.pop
p list
p list.contains?(20)  # true
p list.contains?(30)  # false
p list.contains?('f') # false

list.append(30)

p list.contains?(30) # true
p list.find(20)
p list.find('Cowabunga')

# Build the following methods in your linked list class:
#   1. append(value) adds a new node containing value to the end of the list
#   2. prepend(value) adds a new node containing value to the start of the list
#   3. size returns the total number of nodes in the list
#   4. head returns the first node in the list
#   5. tail returns the last node in the list
#   6. at(index) returns the node at the given index
#   7. pop removes the last element from the list
#   8. contains?(value) returns true if the passed in value is in the list
#      and otherwise returns false.
#   9. find(value) returns the index of the node containing value, or nil
#      if not found.
#  10. to_s represent your LinkedList objects as strings, so you can print
#      them out and preview them in the console. The format should be:
#      ( value ) -> ( value ) -> ( value ) -> nil
#
# Extra Credit
#   1. insert_at(value, index) that inserts a new node with the provided value
#      at the given index.
#   2. remove_at(index) that removes the node at the given index.
# Extra Credit Tip: When you insert or remove a node, consider how it will
# affect the existing nodes. Some of the nodes will need their #next_node
# link updated.
