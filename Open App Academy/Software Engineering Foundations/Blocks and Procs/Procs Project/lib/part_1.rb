def my_map(arr, &prc)
    new_arr = [];
    arr.each_with_index do |ele, i| 
        new_arr[i] = prc.call(ele)
    end
    return new_arr
end

def my_select(arr, &prc)
    new_arr = [];
    arr.each do |ele|
        if prc.call(ele)
            new_arr << ele
        end
    end
    return new_arr
end

def my_count(arr, &prc)
    count = 0;
    arr.each do |ele|
        if prc.call(ele)
            count+=1
        end
    end
    return count
end

def my_any?(arr, &prc)
    return my_count(arr, &prc) > 0
end

def my_all?(arr, &prc)
    len = arr.length()
    return my_count(arr, &prc) == len
end

def my_none?(arr, &prc)
    return my_count(arr, &prc) == 0
end