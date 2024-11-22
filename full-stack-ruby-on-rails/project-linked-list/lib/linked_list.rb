# frozen_string_literal: true

require_relative './node'

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
    nil
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

    loop do
      index = counter if reference.data == value
      break if (reference.data == value) || reference.next_node.nil?

      reference = reference.next_node
      counter += 1
    end

    index
  end

  def insert_at(value, index)
    if @head.nil?
      @head = Node.new(value)
      return
    end

    if index <= 0
      prefix(value)
      return
    end

    counter = 0
    list_length = size - 1
    n_current = @head
    n_previous = nil

    loop do
      if counter == index
        temp = Node.new(value)
        temp.next_node = n_current
        n_previous.next_node = temp
        break
      elsif counter == list_length
        append(value)
        break
      else
        n_previous = n_current unless counter.zero?
        n_current = n_current.next_node
      end

      counter += 1
    end
  end

  def remove_at(index)
    return if @head.nil? || index.negative? || index > size - 1

    if index.zero?
      @head = @head.next_node.nil? ? nil : @head.next_node
      return
    end

    if @head.next_node.nil?
      @head = nil
      return
    end

    counter = 1
    n_previous = @head
    n_current = @head.next_node

    loop do
      if counter == index
        n_next = n_current.next_node.nil? ? nil : n_current.next_node
        n_previous.next_node = n_next
        break
      else
        break if n_current.next_node.nil?

        n_previous = n_current
        n_current = n_current.next_node
        counter += 1
      end
    end
  end

  def to_s
    return nil if @head.nil?

    string = ''
    pointer = ' -> '
    reference = @head

    loop do
      string += "( #{reference.data} )#{pointer}"
      break if reference.next_node.nil?

      reference = reference.next_node
    end

    "#{string}nil"
  end

  def find_tail
    current_node = @head
    current_node = current_node.next_node while current_node.next_node
    current_node
  end
end
