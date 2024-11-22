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
    empty? ? @head = node : tail.next = node
  end

  def size
    if empty?
      0
    else
      count_all_nodes(node: @head, counter: 1)
    end
  end

  def at(index)
    return @head if index.zero?

    counter = 0
    list_length = size - 1
    reference = @head

    loop do
      if counter == index
        return reference
      elsif counter == list_length
        return nil
      else
        reference = reference.next
        counter += 1
      end
    end
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

    reference = @head
    match = false

    loop do
      match = reference.data == value

      break if match || reference.next.nil?

      reference = reference.next
    end

    match
  end

  def find(value)
    return nil if empty?

    reference = @head
    counter = 0
    index = nil

    loop do
      index = counter if reference.data == value
      break if (reference.data == value) || reference.next.nil?

      reference = reference.next
      counter += 1
    end

    index
  end

  def insert_at(value, index)
    if empty?
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
        temp.next = n_current
        n_previous.next = temp
        break
      elsif counter == list_length
        append(value)
        break
      else
        n_previous = n_current unless counter.zero?
        n_current = n_current.next
      end

      counter += 1
    end
  end

  def remove_at(index)
    return if empty? || out_of_range?(index)

    if index.zero?
      @head = @head.next.nil? ? nil : @head.next
      return
    end

    if @head.next.nil?
      @head = nil
      return
    end

    counter = 1
    n_previous = @head
    n_current = @head.next

    loop do
      if counter == index
        n_next = n_current.next.nil? ? nil : n_current.next
        n_previous.next = n_next
        break
      else
        break if n_current.next.nil?

        n_previous = n_current
        n_current = n_current.next
        counter += 1
      end
    end
  end

  def to_s
    return nil if empty?

    string = ''
    pointer = ' -> '
    reference = @head

    loop do
      string += "( #{reference.data} )#{pointer}"
      break if reference.next.nil?

      reference = reference.next
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

  def count_all_nodes(node:, counter:)
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
