# frozen_string_literal: true

require_relative './node'

# A class to manage relationships between nodes
class LinkedList
  attr_reader :head

  def initialize
    @head = nil
  end

  def prefix(value)
    @head = if empty?
              Node.new(value)
            else
              Node.new(value, @head)
            end
  end

  def append(value)
    node = Node.new(value)
    if empty?
      @head = node
    else
      tail.next = node
    end
  end

  def size
    if empty?
      0
    else
      count_all_nodes(node: @head)
    end
  end

  def at(index_to_find)
    return @head if index_to_find.zero?

    node = @head
    size.times do |list_index|
      return node if index_to_find == list_index

      node = node.next || nil
    end
    node
  end

  def pop
    return nil if empty?

    new_tail = second_to_last_node
    old_tail = new_tail.next
    new_tail.next = nil

    old_tail
  end

  def contains?(value)
    return false if empty?

    find?(value)
  end

  def find?(value)
    !!find(value)
  end

  def find(value)
    return nil if empty?

    index_of_value = nil
    node = @head

    size.times do |index|
      if node.data == value
        index_of_value = index
        break
      else
        node = node.next
      end
    end

    index_of_value
  end

  def insert_at(value, index)
    return prefix(value) if empty? || index <= 0

    node_created = false
    current_node = @head
    previous_node = nil

    size.times do |list_index|
      if list_index == index
        temp = Node.new(value)
        temp.next = current_node
        previous_node.next = temp
        node_created = true
        break
      else
        previous_node = current_node
        current_node = current_node.next
      end
    end

    append(value) unless node_created
  end

  def remove_at(index)
    return if empty? || out_of_range?(index)

    if @head.next.nil?
      @head = nil
      return
    end

    if index.zero?
      @head = @head.next
      return
    end

    previous_node = nil
    current_node = @head

    size.times do |list_index|
      if list_index == index
        next_node = current_node.next ||= nil
        previous_node.next = next_node
        break
      else
        previous_node = current_node
        current_node = current_node.next
      end
    end
  end

  def to_s
    return nil if empty?

    string = ''
    pointer = ' -> '
    node = @head

    size.times do
      string += "( #{node.data} )#{pointer}"
      node = node.next
    end

    "#{string}nil"
  end

  def tail
    current_node = @head
    current_node = current_node.next while current_node.next
    current_node
  end

  def empty?
    @head.nil?
  end

  private

  def count_all_nodes(node:)
    counter = 1
    last_node = tail
    while node != last_node
      counter += 1
      node = node.next
    end
    counter
  end

  def second_to_last_node
    node = @head
    node = node.next until node.next.next.nil?
    node
  end

  def out_of_range?(index)
    (index.negative? || index > size - 1)
  end
end
