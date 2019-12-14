def is_prime?(num)
    return false if num < 2
    (2...num).each {|n| return false if num%n == 0}
    return true
end

def nth_prime(number)
    count = 0
    num = 1
    while(count != number)
        num += 1
        count += 1 if is_prime?(num)
    end
    return num
end

def prime_range(min, max)
    arr = []
    num = min
    while (num <= max)
        arr << num if is_prime?(num)
        num += 1
    end
    return arr
end