def palindrome?(str)
    len = str.length
    (0..len-1).each do |n|
        if str[n] != str[len-1-n]
            return false
        end
    end
    return true
end

def substrings(str)
    arr = []
    len = str.length
    str.each_char.with_index do |char, ind|
        arr << char
        prev = char
        if (ind != len-1)
            (ind+1..len-1).each do |n|
                prev += str[n]
                arr << prev
            end
        end
    end
    return arr  
end

def palindrome_substrings(str)
    arr = substrings(str)
    pal_arr = []
    arr.each do |ele|
        if ele.length != 1 and (palindrome?(ele))
            pal_arr << ele
        end
    end
    return pal_arr
end