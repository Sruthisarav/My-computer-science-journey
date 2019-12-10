def all_words_capitalized?(arr)
    return arr.all?{|str| str == str[0].upcase + str[1..str.length-1].downcase}
end

def no_valid_url?(arr)
    def check(e)
        valid = ['.com', '.net', '.io', '.org']
        valid.each do |v| 
            if e.include?(v)
                return true
            end
        end
        return false
    end
    arr.none? {|w| check(w)}
end

def any_passing_students?(arr)
    def average(a)
        total = a.inject(0){|sum, n| sum + n}
        return total/a.length
    end
    arr.any? {|student| average(student[:grades]) >= 75}
end