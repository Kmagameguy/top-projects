# frozen_string_literal: true

# A class to manage mathematical operations
class Calculator
  def add(*args)
    args.reduce(:+)
  end

  def multiply(*args)
    args.reduce(:*)
  end

  def subtract(*args)
    args.reduce(:-)
  end
end
