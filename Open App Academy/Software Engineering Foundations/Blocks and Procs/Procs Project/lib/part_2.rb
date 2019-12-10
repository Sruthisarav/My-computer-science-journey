def reverser(str, &prc)
    new_str = str.reverse
    return prc.call(new_str)
end

def word_changer(str, &prc)
    arr = str.split(" ")
    new_arr = []
    arr.each_with_index do |ele, i|
        new_arr[i] = prc.call(ele)
    end
    return new_arr.join(" ")
end

def greater_proc_value(n, prc1, prc2)
    result1 = prc1.call(n)
    result2 = prc2.call(n)
    if result1 > result2
        return result1
    else
        return result2
    end
end

def and_selector(arr, prc1, prc2)
    new_arr = []
    arr.each do |ele|
        result1 = prc1.call(ele)
        result2 = prc2.call(ele)
        if result1 && result2
            new_arr << ele
        end
    end
    return new_arr
end

def alternating_mapper(arr, prc1, prc2)
    new_arr = []
    arr.each_with_index do |ele, i|
        if i % 2 == 0
            new_arr << prc1.call(ele)
        else
            new_arr << prc2.call(ele)
        end
    end
    return new_arr
end