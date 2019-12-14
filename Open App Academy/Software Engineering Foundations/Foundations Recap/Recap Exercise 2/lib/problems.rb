# Write a method, least_common_multiple, that takes in two numbers and returns the smallest number that is a mutiple
# of both of the given numbers
def least_common_multiple(num_1, num_2)
    return num_1 if num_1 == num_2
    result = num_1 * num_2
    result.downto(num_1).each do |n|
        if n%num_1 == 0 && n%num_2 == 0
            result = n
        end
    end
    return result
end


# Write a method, most_frequent_bigram, that takes in a string and returns the two adjacent letters that appear the
# most in the string.
def most_frequent_bigram(str)
    substrings = []
    (0..str.length-2).each {|i| substrings << str[i...i+2] }
    result = [0, ""]
    substrings.each do |bigram|
        count = (str.split(bigram)).length
        if count > result[0]
            result = [count, bigram]
        end
    end
    return result[1]
end


class Hash
    # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
    def inverse
        newHash = {}
        self.each do |k, v|
            newHash[v] = k
        end
        return newHash
    end
end


class Array
    # Write a method, Array#pair_sum_count, that takes in a target number returns the number of pairs of elements that sum to the given target
    def pair_sum_count(num)
        count = 0
        self.each_with_index do |num1, i1|
            self.each_with_index do |num2, i2|
                count += 1 if i1 > i2 && num1 + num2 == num
            end
        end
        return count
    end

    # Write a method, Array#bubble_sort, that takes in an optional proc argument.
    # When given a proc, the method should sort the array according to the proc.
    # When no proc is given, the method should sort the array in increasing order.
    #
    # Sorting algorithms like bubble_sort, commonly accept a block. That block accepts
    # two parameters, which represents the two elements in the array being compared.
    # If the block returns 1, it means that the second element passed to the block
    # should go before the first (i.e. switch the elements). If the block returns -1,
    # it means the first element passed to the block should go before the second
    # (i.e. do not switch them). If the block returns 0 it implies that
    # it does not matter which element goes first (i.e. do nothing).
    #
    # This should remind you of the spaceship operator! Convenient :)
    def bubble_sort(&prc)
        prc ||= Proc.new {|a, b| a <=> b}
        swapped = true
        while (swapped)
            swapped = false
            (0...self.length-1).each do |i|
                if prc.call(self[i], self[i+1]) == 1
                    self[i], self[i+1] = self[i+1], self[i]
                    swapped = true
                end
            end
        end
        return self
    end
end
