def bubble_sort(array)
  max_iterations = array.length

  while max_iterations > 1 do
    index = 0
    while index < array.length - 1 do
      current_position = array[index]
      next_position = array[index + 1]

      if current_position > next_position
        array[index] = next_position
        array[index + 1] = current_position
      end
      index += 1
    end
    max_iterations -= 1
  end
  p array
end

bubble_sort([4,3,78,2,0,2])
