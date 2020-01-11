module Enumerable
    def my_each
        for i in 0...self.length do
            yield(self[i])
        end
        return self
    end
    def my_each_with_index
        for i in 0...self.length do
            yield(self[i], i)
        end
        return self
    end
    def my_select
        new_arr = []
        self.my_each do |ele|
            new_arr << ele if yield(ele)
        end
        return new_arr
    end
    def my_all?
        self.my_each {|ele| return false if !yield(ele)}
        return true
    end
    def my_any?
        self.my_each {|ele| return true if yield(ele)}
        return false
    end
    def my_none?
        self.my_each {|ele| return false if yield(ele)}
        return true
    end
    def my_count
        count = 0
        self.my_each {|ele| count += 1 if yield(ele)}
        return count
    end
    def my_map(prc=nil)
        new_arr = []
        self.my_each do |ele| 
            unless block_given?
                new_arr << prc.call(ele)
            else
                new_arr << yield(ele)
            end
        end
        return new_arr
    end
    def my_inject(accumulator=nil)
        for i in 0...self.length do
            if accumulator != nil
                accumulator = yield(accumulator, self[i]) 
            else
                accumulator = self[0]
            end
        end
        return accumulator
    end
end

[3, 2, 1].my_each {|num| puts num}
p '---'
['a', 'b', 'c'].my_each_with_index {|ele, i| puts "#{i}: #{ele}"}
p '---'
p [1, 2, 3, 4, 5].my_select {|num| num > 3}
p '---'
p [1, 2, 4, 5].my_all? {|num| num > 0}
p [1, 5, -1].my_all? {|num| num < 0}
p '---'
p [1, 4, 5].my_any? {|num| num >= 5}
p ['a', 'b', 'c'].my_any? {|char| char == 'd'}
p '---'
p [1, 3, 5].my_none? {|num| num < 0}
p [1, 5, 6].my_none? {|num| num > 5}
p '---'
p [1, 5, 7, 9].my_count {|num| num >= 6}
p '---'
p [1, 2, 3, 4].my_map(Proc.new {|num| num*2})
p '---'
p [1, 2, 3, 4].my_inject {|sum, num| sum*num}
p '---'
def multiply_els(arr)
    return arr.my_inject {|result, num| result * num}
end
p multiply_els([1,2,3,4])
