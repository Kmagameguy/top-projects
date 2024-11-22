# frozen_string_literal: true

# A class which holds a value and links to sub-nodes
class Node
  include Comparable

  attr_accessor :value, :left, :right

  def initialize(value, left: nil, right: nil)
    @value = value
    @left = left
    @right = right
  end

  def <=>(other)
    @value <=> other
  end
end
