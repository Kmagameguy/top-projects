# Assignment:
# Build a bubble sort method.  Bubble sort works by
# Looking at a list of numbers and comparing them in
# two-by-two chunks, from left-to-right
# When evaluating a chunk, it compares whether the left number is greater than
# the number to its right.  If so, it swaps the numbers' positions in the list.
#
# An interesting feature of the bubble sort is that after the first pass,
# you can count on the right-most number to be the largest in the list
# So, to know when the list is started you can decrement the list travel by
# 1 position after each iteration.
#
# Example:
# [ 4, 3, 78, 2, 0, 2 ]
# [ 3, 4, 2, 0, 2, 78 ] <= 78 is the largest and "floats-right" after first iteration
# [ 3, 2, 0, 2, 4 ] <= skip checking 78; second largest number is now 4
# [ 2, 0, 2, 3 ]  <= skip checking 4; third largest number is now 3
# [ 0, 2, 2 ] <= skip checking 3; fourth largest number is now 2
# [ 0, 2 ] <= skip checking 2; no-op, fifth largest number is 2 as well
# [ 0 ] <= skip checking 2; no-op, sixth largest number is 0 (we don't need to run this iteration, just illustration here)
#
# create a variable to keep track of our iterations:
#   - max_iterations = sequence.length
# within each iteration:
# 1. Create a temporary var to store our position in the list (0)
# 2. Look at position and position + 1 items
# 3. If first > second swap position and position + 1
# 4. Increment position var
# 5. repeat #2 - #4 max_iterations times
# 6. Decrement iterations var by 1
# 7. Repeat #1 - #6 until max_iterations is exhausted
# 8. Return the result, which should now be sorted

def bubble_sort(sequence)
  p sequence
end

bubble_sort([4,3,78,2,0,2])
