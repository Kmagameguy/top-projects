def stock_picker(prices)
  # found Array#combination from here:
  # https://ruby-doc.org/3.2.1/Array.html#method-i-combination
  # Ruby seems to have a method for everything
  profit_matrix = prices.combination(2).reduce(Hash.new({})) do |hash, price_group|
    purchase_price = price_group[0]
    sale_price = price_group[1]
    profit = sale_price - purchase_price
    hash[profit] = { :purchase_price => purchase_price, :sale_price => sale_price }

    hash
  end

  purchase_date = prices.index(profit_matrix.max[1][:purchase_price])
  sale_date = prices.index(profit_matrix.max[1][:sale_price])
  p [ purchase_date, sale_date ]
end

stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
