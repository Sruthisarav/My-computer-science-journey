def stock_picker(stock_prices)
    profit = 0
    stock_indexes = []
    stock_prices[0...-1].each_with_index do |buying_p, buying_i|
        stock_prices[buying_i+1..-1].each_with_index do |selling_p, selling_i|
            new_profit = selling_p - buying_p
            if new_profit > profit
                profit = new_profit
                stock_indexes = [buying_i, selling_i+buying_i+1]
            end
        end
    end
    return stock_indexes
end
p stock_picker([17,3,6,9,15,8,6,1,10])