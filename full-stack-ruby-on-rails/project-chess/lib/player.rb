# frozen_string_literal: true

# A class which represents a player character
class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end
end
