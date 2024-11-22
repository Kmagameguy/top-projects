def merge_sort(array)
  return array if array.size < 2

  half = array.size/2.0
  left, right, remainder = array.each_slice(half).to_a
  right += remainder unless remainder.nil?

  merge(merge_sort(left), merge_sort(right))
end

def merge(left_array, right_array)
  temp_array = []

  until left_array.empty? || right_array.empty?
    temp_array << if left_array.first < right_array.first
                    left_array.shift
                  else
                    right_array.shift
                  end
  end

  temp_array << right_array << left_array
  temp_array.flatten
end

array = [4, 8, 6, 2, 1, 7, 5, 3]
p merge_sort array

array = [1, 7, 5, 3, 2, 6, 4]
p merge_sort array

array = []
p merge_sort array

array = [-4, 3, 200, 16, -33, 10000]
p merge_sort array

array = [1, 7, 8, 3, 1, 15, -43, 22]
p merge_sort array
