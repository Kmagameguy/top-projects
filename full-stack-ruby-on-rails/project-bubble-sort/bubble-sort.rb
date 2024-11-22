def bubble_sort(sequence)
  max_iterations = sequence.length

  while max_iterations > 1 do
    index = 0
    while index < sequence.length - 1 do
      current_position = sequence[index]
      next_position = sequence[index + 1]

      if current_position > next_position
        sequence[index] = next_position
        sequence[index + 1] = current_position
      end
      index += 1
    end
    max_iterations -= 1
  end
  p sequence
end

bubble_sort([4,3,78,2,0,2])
