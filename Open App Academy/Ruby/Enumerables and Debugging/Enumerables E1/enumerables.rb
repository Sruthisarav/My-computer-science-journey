class Array
    def my_each(&prc)
        len = self.length
        count = 0
        while(count != len)
            prc.call(self[count])
            count += 1
        end
        return self
    end
    def my_select(&prc)
        newArr = []
        self.my_each {|ele| newArr << ele if prc.call(ele)}
        return newArr
    end
    def my_reject(&prc)
        newArr = []
        self.my_each {|ele| newArr << ele if !prc.call(ele)}
        return newArr
    end
    def my_any?(&prc)
        self.my_each {|ele| return true if prc.call(ele)}
        return false
    end
    def my_all?(&prc)
        self.my_each {|ele| return false if !prc.call(ele)}
        return true
    end
    def my_flatten
        if self[0].kind_of?(Array)
            return self[0].my_flatten + self[1..-1].my_flatten
        elsif self.empty?
            return []
        else
            return [self[0]] + self[1..-1].my_flatten
        end
    end
    def my_zip(*arrs)
        newArr = []
        col = arrs.length + 1
        row = self.length
        (0...row).each do |i|
            newArr[i] = []
            (0...col).each do |j|
                newArr[i][j] = self[i] if j == 0
                newArr[i][j] = arrs[j-1][i] if j != 0
            end
        end
        return newArr
    end
    def my_rotate(n=1)
        len = self.length
        shift = n%len
        newArr = []
        (0...len).each do |i|
            newArr << self[(i+shift)%len]
        end
        return newArr
    end
    def my_join(sep="")
        newStr = self[0]
        self[1..-1].each do |char|
            newStr = newStr + sep + char
        end
        return newStr
    end
    def my_reverse
        len = self.length
        newArr = []
        (0...len).each do |i|
            newArr[i] = self[len-1-i]
        end
        return newArr
    end
end

#example for my_each
return_value = [1, 2, 3].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end
p return_value

#example for my_select
a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []

#example for my_reject
a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]

#examples for my_any? and my_all?
a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true

#example for my_flatten
p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

#example for my_zip
a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

#example for my_rotate
a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

#example for my_join
a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"

#example for my_reversse
p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
