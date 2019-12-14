def proper_factors(num)
    arr = []
    (1...num).each {|n| arr << n if num%n == 0}
    return arr
end

def aliquot_sum(num)
    return proper_factors(num).inject {|sum, n| sum + n}
end

def perfect_number?(num)
    return num == aliquot_sum(num)
end

def ideal_numbers(n)
    arr = []
    num = 1
    count = 0
    while (count != n)
        if perfect_number?(num)
            arr << num 
            count += 1
        end
        num+= 1
    end
    return arr
end