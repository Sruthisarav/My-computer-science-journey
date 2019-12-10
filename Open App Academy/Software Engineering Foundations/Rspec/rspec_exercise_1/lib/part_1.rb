def average(n1, n2)
    return (n1 + n2)/2.to_f
end

def average_array(array)
    average = array.inject {|acc, ele| acc += ele}
    return average/array.length.to_f
end

def repeat(str, n)
    new_str = ''
    n.times {new_str += str}
    return new_str
end

def yell(str)
    return str.upcase + '!'
end

def alternating_case(str)
    up = true
    str = str.split(' ')
    new_str = []
    str.each do |word|
        if (up)
            new_str << word.upcase
        else
            new_str << word.downcase
        end
        up = !up
    end
    return new_str.join(' ')
end
