def select_even_nums(arr)
    return arr.select{|num| !num.odd?}
end

def reject_puppies(arr)
    return arr.reject {|h| h['age'] <= 2}
end

def count_positive_subarrays(arr)
    return arr.count{|a| a.inject(0){|sum, n| sum + n} > 0}
end

def aba_translate(str)
    vowels = 'aeiou'
    arr = str.split('')
    return arr.inject('') do |new_str, c| 
        if vowels.include?(c)
            new_str + c + 'b' + c
        else
            new_str + c
        end
    end
end

def aba_array(arr)
    return arr.map {|ele| aba_translate(ele)}
end