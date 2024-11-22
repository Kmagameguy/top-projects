module Enumerable
  def my_all?
    if block_given?
      all_match = true
      my_each { |index| all_match = false if yield(index) == false }
      all_match
    else
      self
    end
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    if block_given?
      index = 0
      while index < self.length do
        yield(self[index])
        index += 1
      end
    end
    self
  end
end