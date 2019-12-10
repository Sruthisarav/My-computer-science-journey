def partition(array, n)
    first_half = array.select{|ele| ele < n}
    second_half = array.select{|ele| ele >= n}
    return [first_half, second_half]
end
def merge(hash1, hash2)
    new_hash = { }
    hash1.each do |k, v|
        if hash2.has_key?(k)
            new_hash[k] = hash2[k]
        else
            new_hash[k] = v
        end
    end
    hash2 = hash2.select{|k, v| !new_hash.has_key?(k)}
    hash2.each {|k, v| new_hash[k] = v}  
    return new_hash
end

def censor(sentence, array)
    vowels = 'aeiou'
    separated = sentence.split(' ')
    separated.each do |word|
        if array.include?(word.downcase)
            word.each_char.with_index do |char, i|
                if vowels.include?(char.downcase)
                    word[i] = '*'
                end
            end
        end
    end
    return separated.join(' ')
end

def power_of_two?(n)
    while (n != 1)
        if n % 2 == 1
            return false
        else
            n = n/2
        end
    end
    return true
end