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

  def my_any?
    if block_given?
      some_match = false
      my_each { |index| some_match = true if yield(index) == true }
      some_match
    else
      self
    end
  end

  def my_count
    if block_given?
      count = 0
      my_each { |index| count += 1 if yield(index) == true }
      count
    else
      count = 0
      my_each { count += 1}
      count
    end
  end

  def my_each_with_index
    if block_given?
      index = 0
      my_each do |item|
        yield(item, index)
        index += 1
      end
      self
    end
  end

  def my_inject(collector = 0)
    if block_given?
      my_each { |item| collector = yield(collector, item) }
      collector
    end
  end

  def my_map
    if block_given?
      arr = []
      my_each { |item| arr << yield(item) }
      arr
    end
  end

  def my_none?
    if block_given?
      match = true
      my_any? { |index| match = false if yield(index) }
      match
    end
  end

  def my_select
    if block_given?
      arr = []
      my_each { |item| arr << item if yield(item) }
      arr
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
