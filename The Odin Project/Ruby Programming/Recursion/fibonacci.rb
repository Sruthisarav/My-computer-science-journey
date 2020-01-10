def fibs(n)
    fib_arr = [0, 1]
    return fib_arr[0...n] if n <= 2
    (2...n).each do |i|
        fib_arr << fib_arr[i-1] + fib_arr[i-2]
    end
    return fib_arr
end

#examples for fibs
p fibs(0)
p fibs(1)
p fibs(2)
p fibs(7)

def fibs_rec(n)
    return [0, 1][0...n] if n <= 2
    prev = fibs_rec(n-1)
    return prev << prev[-1] + prev[-2]
end

p fibs_rec(0)
p fibs_rec(1)
p fibs_rec(2)
p fibs_rec(7)