#write your code here
def add(num1, num2)
    return num1 + num2
end

def subtract(num1, num2)
    return num1 - num2
end

def sum(arr)
    return arr.inject(0) {|accumulator, n| accumulator + n}
end

def multiply(num1, num2)
    return num1 * num2
end

def power(a, b)
    return a ** b
end

def factorial(n)
    result = 1;
    (1..n).each do 
        result *= n
    end
    return result
end