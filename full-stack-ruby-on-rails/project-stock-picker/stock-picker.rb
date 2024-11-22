# Assignment: Given stock prices for a list of dates, find
# The pair of days which yield the greatest profit.
# Parameters:
#   1. You MUST buy before you can sell: [buy_date, sell_date]
# Tips:
#   1. Watch out for edge cases, such as the lowest price landing on the last date
#      or the highest price landing on the first date
#   2. If two pairs of dates have the same (highest) profit value, pick the first pair

# Sample stock set:
# [17, 3, 6, 9, 15, 8, 6, 1, 10]
#
# For each pair of prices, calculate the profit
#   example: [(3 - 17), (6 - 3), (9 - 6), (15 - 9), (8 - 15), (6 - 8), (1 - 6), (10 - 1)]
#   result:  {
#              -14 => [17, 3],
#                3 => [3, 6],
#                3 => [6, 9],
#                6 => [9, 15],
#               -7 => [15, 8],
#               -2 => [8, 6],
#               -5 => [6, 1],
#                9 => [10, 1],
#               [...]
#            }
# From the resulting profit set, pick the highest earner (9)
# Find the index of the two numbers inside prices and return those as a pair:
# => [1, 4]

def stock_picker(prices)
  # found Array#combination from here:
  # https://ruby-doc.org/3.2.1/Array.html#method-i-combination
  # Ruby seems to have a method for everything
  stonks = prices.combination(2).reduce(Hash.new({})) do |hash, price_group|
    p price_group
  end
end

stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
