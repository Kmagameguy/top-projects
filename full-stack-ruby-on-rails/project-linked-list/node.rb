# frozen_string_literal: true

# A class which holds some data and a reference to another node
class Node
  attr_accessor :next_node
  attr_reader :data

  def initialize(data = nil)
    @data = data
    @next_node = nil
  end
end
