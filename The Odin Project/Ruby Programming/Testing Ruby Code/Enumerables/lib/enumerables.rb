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
        return true if self.empty?
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