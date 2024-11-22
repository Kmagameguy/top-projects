def bubble_sort(array)
  max_iterations = array.length

  while max_iterations > 1 do
    array.each_with_index do |value, index|
      current_value = value
      next_value = array[index + 1]
      break if next_value.nil?

      if current_value > next_value
        array[index] = next_value
        array[index + 1] = current_value
      end
    end
    max_iterations -= 1
  end
  p array
end

bubble_sort([4,3,78,2,0,2])
