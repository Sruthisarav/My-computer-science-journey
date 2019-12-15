def strange_sums(arr)
    count = 0
    arr.each_with_index do |n, i|
        arr.each_with_index do |num, ind|
            count += 1 if ind > i && n + num == 0
        end
    end
    return count
end

p strange_sums([2, -3, 3, 4, -2])     # 2
p strange_sums([42, 3, -1, -42])      # 1
p strange_sums([-5, 5])               # 1
p strange_sums([19, 6, -3, -20])      # 0
p strange_sums([9])                   # 0

def pair_product(arr, product)
    arr.each_with_index do |n, i|
        arr.each_with_index do |num, ind|
            return true if ind > i && n * num == product
        end
    end
    return false
end
p pair_product([4, 2, 5, 8], 16)    # true
p pair_product([8, 1, 9, 3], 8)     # true
p pair_product([3, 4], 12)          # true
p pair_product([3, 4, 6, 2, 5], 12) # true
p pair_product([4, 2, 5, 7], 16)    # false
p pair_product([8, 4, 9, 3], 8)     # false
p pair_product([3], 12)             # false

def rampant_repeats(str, hash)
    newStr = ""
    str.each_char do |char|
        if hash.key?(char)
            hash[char].times do 
                newStr += char
            end
        else
            newStr += char
        end
    end
    return newStr
end

p rampant_repeats('taco', {'a'=>3, 'c'=>2})             # 'taaacco'
p rampant_repeats('feverish', {'e'=>2, 'f'=>4, 's'=>3}) # 'ffffeeveerisssh'
p rampant_repeats('misispi', {'s'=>2, 'p'=>2})          # 'mississppi'
p rampant_repeats('faarm', {'e'=>3, 'a'=>2})            # 'faaaarm'

def perfect_square(num)
    (1...num).each do |n|
        return true if n*n == num
    end
    return false
end

p perfect_square(1)     # true
p perfect_square(4)     # true
p perfect_square(64)    # true
p perfect_square(100)   # true
p perfect_square(169)   # true
p perfect_square(2)     # false
p perfect_square(40)    # false
p perfect_square(32)    # false
p perfect_square(50)    # false

def factors(num)
    factor = []
    (2...num).each do |n|
        factor << n if num % n == 0
    end
    return factor
end

def anti_prime?(num)
    factor = factors(num)
    (2...num).each do |n|
        return false if factors(n).length > factor.length
    end
    return true
end
p anti_prime?(24)   # true
p anti_prime?(36)   # true
p anti_prime?(48)   # true
p anti_prime?(360)  # true
p anti_prime?(1260) # true
p anti_prime?(27)   # false
p anti_prime?(5)    # false
p anti_prime?(100)  # false
p anti_prime?(136)  # false
p anti_prime?(1024) # false

def matrix_addition(matrix1, matrix2)
    row = matrix1.length
    col = matrix1[0].length
    newMat = []
    (0...row).each do |i|
        newMat[i] = []
        (0...col).each do |j|
            newMat[i][j] = matrix1[i][j] + matrix2[i][j]
        end
    end
    return newMat
end
matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

p matrix_addition(matrix_a, matrix_b) # [[11, 6], [7, 7]]
p matrix_addition(matrix_a, matrix_c) # [[1, 5], [4, 6]]
p matrix_addition(matrix_b, matrix_c) # [[8, 1], [3, -1]]
p matrix_addition(matrix_d, matrix_e) # [[2, -5], [19, 14], [6, 4]]

def mutual_factors(*nums)
    min = nums.min
    factors = []
    (1..min).each do |n|
        bool = true
        nums.each do |num|
            bool = false if num%n != 0
        end
        if bool
            factors << n
        end
    end
    return factors
end

p mutual_factors(50, 30)            # [1, 2, 5, 10]
p mutual_factors(50, 30, 45, 105)   # [1, 5]
p mutual_factors(8, 4)              # [1, 2, 4]
p mutual_factors(8, 4, 10)          # [1, 2]
p mutual_factors(12, 24)            # [1, 2, 3, 4, 6, 12]
p mutual_factors(12, 24, 64)        # [1, 2, 4]
p mutual_factors(22, 44)            # [1, 2, 11, 22]
p mutual_factors(22, 44, 11)        # [1, 11]
p mutual_factors(7)                 # [1, 7]
p mutual_factors(7, 9)              # [1]

def tribonacci_number(num)
    return 1 if num == 1
    return 1 if num == 2
    return 2 if num == 3
    return tribonacci_number(num - 1) + tribonacci_number(num - 2) +
        tribonacci_number(num - 3)
end

p tribonacci_number(1)  # 1
p tribonacci_number(2)  # 1
p tribonacci_number(3)  # 2
p tribonacci_number(4)  # 4
p tribonacci_number(5)  # 7
p tribonacci_number(6)  # 13
p tribonacci_number(7)  # 24
p tribonacci_number(11) # 274

def matrix_addition_reloaded(*matrices)
    row = matrices[0].length
    col = matrices[0][0].length
    matrices.each do |matrice|
        return nil if matrice.length != row || matrice[0].length != col
    end
    newMat = []
    (0...row).each do |i|
        newMat[i] = []
        (0...col).each do |j|
            newMat[i][j] = 0
            matrices.each {|matrice| newMat[i][j] += matrice[i][j]}
        end
    end
    return newMat
end

matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

p matrix_addition_reloaded(matrix_a, matrix_b)              # [[11, 6], [7, 7]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)    # [[10, 6], [7, 6]]
p matrix_addition_reloaded(matrix_e)                        # [[0, 0], [12, 4], [6, 3]]
p matrix_addition_reloaded(matrix_d, matrix_e)              # [[2, -5], [19, 14], [6, 4]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)    # nil
p matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)    # nil

def squarocol?(arr)
    row = arr.length
    col = arr[0].length
    arr.each do |r|
        ele = r[0]
        bool = true
        (1...col).each do |i|
            bool = false if r[i] != ele
        end
        return true if bool
    end
    (0...col).each do |col|
        ele = arr[0][col]
        bool = true
        arr.each do |r|
            bool = false if r[col] != ele
        end
        return true if bool
    end
    return false
end

p squarocol?([
    [:a, :x , :d],
    [:b, :x , :e],
    [:c, :x , :f],
]) # true

p squarocol?([
    [:x, :y, :x],
    [:x, :z, :x],
    [:o, :o, :o],
]) # true

p squarocol?([
    [:o, :x , :o],
    [:x, :o , :x],
    [:o, :x , :o],
]) # false

p squarocol?([
    [1, 2, 2, 7],
    [1, 6, 6, 7],
    [0, 5, 2, 7],
    [4, 2, 9, 7],
]) # true

p squarocol?([
    [1, 2, 2, 7],
    [1, 6, 6, 0],
    [0, 5, 2, 7],
    [4, 2, 9, 7],
]) # false

def squaragonal?(arr)
    size = arr.length
    ele1 = arr[0][0]
    bool1 = true
    ele2 = arr[0][size-1]
    bool2 = true
    (1...size).each do |n|
        bool1 = false if arr[n][n] != ele1
    end
    (1...size).each do |n|
        bool2 = false if arr[n][size-1-n] != ele2
    end
    return bool1 || bool2
end

p squaragonal?([
    [:x, :y, :o],
    [:x, :x, :x],
    [:o, :o, :x],
]) # true

p squaragonal?([
    [:x, :y, :o],
    [:x, :o, :x],
    [:o, :o, :x],
]) # true

p squaragonal?([
    [1, 2, 2, 7],
    [1, 1, 6, 7],
    [0, 5, 1, 7],
    [4, 2, 9, 1],
]) # true

p squaragonal?([
    [1, 2, 2, 5],
    [1, 6, 5, 0],
    [0, 2, 2, 7],
    [5, 2, 9, 7],
]) # false

def pascals_triangle(n)
    arr = []
    (0...n).each do |row|
        arr << [1] if row == 0
        arr << [1, 1] if row == 1
        if row > 1
            array = []
            (0..row).each do |num|
                if num == 0 || num == row
                    array << 1 
                else
                    array << arr[row-1][num-1] + arr[row-1][num]
                end
            end
            arr << array if row 
        end
    end
    return arr
end

p pascals_triangle(5)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1]
# ]

p pascals_triangle(7)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1],
#     [1, 5, 10, 10, 5, 1],
#     [1, 6, 15, 20, 15, 6, 1]
# ]

def prime?(n)
    return false if n < 2
    (2...n).each do |num|
        return false if n%num == 0
    end
    return true
end

def mersenne_prime(n)
    count = 1
    mersenne_prime = 3
    twoCount = 3
    while(count != n)
        num = 2 ** twoCount - 1
        if prime?(num)
            count += 1
            mersenne_prime = num
        end
        twoCount += 1
    end
    return mersenne_prime
end

p mersenne_prime(1) # 3
p mersenne_prime(2) # 7
p mersenne_prime(3) # 31
p mersenne_prime(4) # 127
p mersenne_prime(6) # 131071

def triangular_word?(str)
    alphabets = "abcdefghijklmnopqrstuvwxyz"
    sum = 0
    str.each_char {|char| sum += alphabets.index(char) + 1}
    triangle = 1
    count = 2
    while(triangle < sum)
        triangle = (count * (count + 1))/2
        count += 1
    end
    return true if sum == triangle
    return false
end

p triangular_word?('abc')       # true
p triangular_word?('ba')        # true
p triangular_word?('lovely')    # true
p triangular_word?('question')  # true
p triangular_word?('aa')        # false
p triangular_word?('cd')        # false
p triangular_word?('cat')       # false
p triangular_word?('sink')      # false

def consecutive_collapse(arr)
    removed = true
    while(removed)
        removed = false
        arr.each_with_index do |ele, i|
            if (i == arr.length - 1)
                break
            elsif ele + 1 == arr[i+1] || ele - 1 == arr[i+1]
                arr.slice!(i, 2)
                removed = true
            end
        end
    end
    return arr
end

p consecutive_collapse([3, 4, 1])                     # [1]
p consecutive_collapse([1, 4, 3, 7])                  # [1, 7]
p consecutive_collapse([9, 8, 2])                     # [2]
p consecutive_collapse([9, 8, 4, 5, 6])               # [6]
p consecutive_collapse([1, 9, 8, 6, 4, 5, 7, 9, 2])   # [1, 9, 2]
p consecutive_collapse([3, 5, 6, 2, 1])               # [1]
p consecutive_collapse([5, 7, 9, 9])                  # [5, 7, 9, 9]
p consecutive_collapse([13, 11, 12, 12])              # []

def prime?(n)
    return false if n < 2
    (2...n).each do |num|
        return false if n%num == 0
    end
    return true
end

def prime(n, min, shift)
    pr = min
    count = 0
    num = min + shift
    while(count != n)
        if prime?(num)
            count += 1
            pr = num
        end
        num += shift
        return nil if num < 1
    end
    return pr
end

def pretentious_primes(arr, n)
    arr.each_with_index do |ele, i|
        if n > 0
            arr[i] = prime(n, ele, 1)
        elsif n < 0
            arr[i] = prime(-n, ele, -1)
        end
    end
    return arr
end


p pretentious_primes([4, 15, 7], 1)           # [5, 17, 11]
p pretentious_primes([4, 15, 7], 2)           # [7, 19, 13]
p pretentious_primes([12, 11, 14, 15, 7], 1)  # [13, 13, 17, 17, 11]
p pretentious_primes([12, 11, 14, 15, 7], 3)  # [19, 19, 23, 23, 17]
p pretentious_primes([4, 15, 7], -1)          # [3, 13, 5]
p pretentious_primes([4, 15, 7], -2)          # [2, 11, 3]
p pretentious_primes([2, 11, 21], -1)         # [nil, 7, 19]
p pretentious_primes([32, 5, 11], -3)         # [23, nil, 3]
p pretentious_primes([32, 5, 11], -4)         # [19, nil, 2]
p pretentious_primes([32, 5, 11], -5)         # [17, nil, nil]
