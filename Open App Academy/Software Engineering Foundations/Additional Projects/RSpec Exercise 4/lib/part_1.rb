def my_reject(arr, &prc)
    newArr = []
    arr.each {|ele| newArr << ele if !prc.call(ele)}
    return newArr
end

def my_one?(arr, &prc)
    count = 0
    arr.each {|ele| count += 1 if prc.call(ele)}
    return count == 1
end

def hash_select(hash, &prc)
    newHash = {}
    hash.each {|k, v| newHash[k] = v if prc.call(k, v)}
    return newHash
end

def xor_select(arr, prc1, prc2)
    newArr = []
    arr.each do |ele|
        if prc1.call(ele) && !prc2.call(ele) ||
            !prc1.call(ele) && prc2.call(ele)
            newArr << ele
        end
    end
    return newArr
end

def proc_count(value, arr)
    count = 0
    arr.each {|prc| count += 1 if prc.call(value)}
    return count
end
