def fibs(num)
  arr = [0, 1]
  index = arr.size
  while index < num
    arr << (arr[index - 1] + arr[index - 2])
    index += 1
  end
  arr
end

def fibs_rec(num, array = [0, 1])
  return array if num <= 2
  array << (array[-1] + array[-2])
  fibs_rec(num-1, array)
end

p fibs(8)
p fibs_rec(8)
