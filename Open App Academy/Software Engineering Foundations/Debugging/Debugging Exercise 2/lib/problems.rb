# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

def largest_prime_factor(n)
    def prime?(x)
        if x < 2
            return false
        else
            (2..x-1).each do |e|
                if x % e == 0
                    return false
                end
            end
            return true
        end
    end
    count = n
    while (count >= 2)
        if n % count == 0 and prime?(count)
            return count
        else
            count = count - 1
        end
    end
end

def unique_chars?(str)
    check = str.split('')
    str.each_char do |char|
        check.shift()
        if check.include?(char)
            return false
        end
    end
    return true
end

def dupe_indices(arr)
    default_hash = Hash.new(-1)
    dupe_hash = {}
    arr.each_with_index do |ele, i|
        if dupe_hash[ele] == nil
            dupe_hash[ele] = [i]
        else
            dupe_hash[ele] = dupe_hash[ele].push(i)
        end
    end
    dupe_hash.each do |key, value|
        if value.length == 1
            dupe_hash.delete(key)
        end
    end
    return dupe_hash
end

def ana_array(arr1, arr2)
    if arr1.length != arr2.length
        return false
    end
    arr1.each do |ele|
        if !arr2.include?(ele)
            return false
        else
            arr2.delete_at(arr2.index(ele))
        end
    end
    return true
end
