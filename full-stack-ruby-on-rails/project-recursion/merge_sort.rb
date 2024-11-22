def merge_sort(array)
  return array if array.size < 2

  half = array.size/2.0
  left, right, remainder = array.each_slice(half).to_a
  right += remainder unless remainder.nil?

  merge(merge_sort(left), merge_sort(right))
end

def merge(left_array, right_array)
  temp_array = []

  while !left_array.empty? && !right_array.empty?
    if left_array[0] < right_array[0]
      temp_array << left_array.shift
    else
      temp_array << right_array.shift
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

# Given an array:
# on input of n elements
# if n < 2, return n
# otherwise
#   sort left half of elements
#   sort right half of elements
#   merge sorted halves

# mergeSort(a[0..n])
#   if n > 1
#     copy a[0..n/2] into b
#     copy a[n/2+1..n] into c
#     mergeSort(b[0..n/2])
#     mergeSort(c[0..n/2])
#     merge(b,c,a)
# merge (b[0..p], c[0..q], a[0..p+q])
#  index_b = 0, index_c = 0, index_a = 0
#  while index_b <= b.size && index_c <= c.size
#    if b[index_b] < c[index_c]
#      a[index_a] = b[index_b]; index_b += 1
#    else
#      a[index_a] = c[index_c]; index_c += 1
#    end
#    index_a += 1
#  end
#  if index_b == b.size
#    a << c[index_c..-1]
#  else
#    a << b[index_b..-1]

# Example array [4, 8, 6, 2, 1, 7, 5, 3]
# becomes [4, 8, 6, 2] and [1, 7, 5, 3]
# becomes [4, 8] and [6, 2]
# becomes [4] and [8]
# becomes new array of [4, 8]
# becomes [6] and [2]
# becomes new array of [2, 6]
# compare 4 and 2
# bring 2 down to new array
# compare 4 and 6
# bring 4 down to new array
# compare 8 and 6
# bring 6 down to new array
# bring 8 down to new array
# becomes [2, 4, 6, 8]
# [1, 7, 5, 3] becomes [1, 7] and [5, 3]
# becomes [1] and [7]
# becomes new array of [1, 7]
# becomes [5] and [3]
# becomes new array of [3, 5]
# compare 1 and 3
# bring 1 down to new array
# compare 7 and 3
# bring 3 down to new array
# compare 7 and 5
# bring 5 down to new array
# bring 7 down to new array
# becomes [1, 3, 5, 7]
# merge [2, 4, 6, 8] and [1, 3, 5, 7]
# compare 2 and 1
# bring 1 down to new array
# compare 2 and 3
# bring 2 down to new array
# compare 4 and 3
# bring 3 down to new array
# compare 4 and 5
# bring 4 down to new array
# compare 6 to 5
# bring 5 down to new array
# compare 6 to 7
# bring 6 down to new array
# compare 8 to 7
# bring 7 down to new array
# bring 8 down to new array
