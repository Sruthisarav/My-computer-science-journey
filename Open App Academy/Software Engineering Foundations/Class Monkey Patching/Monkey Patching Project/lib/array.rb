# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    def span
        if self.empty?
            return nil
        else
            self.max() - self.min()
        end
    end
    def average
        if self.empty?
            return nil
        else
            total = 0.0;
            self.each { |n| total += n }
            return total/self.length
        end
    end
    def median
        sorted = self.sort
        len = sorted.length
        if self.empty?
            return nil
        elsif len % 2 == 1
            return sorted[len/2]
        else
            return (sorted[len/2] + sorted[len/2 - 1])/2.0
        end
    end
    def counts
        h = Hash.new(0)
        self.each { |e| h[e] += 1 }
        return h
    end
    def my_count(value)
        count = 0
        self.each {|ele| count += 1 if ele == value}
        return count
    end
    def my_index(value)
        self.each_with_index {|ele, i| return i if ele == value}
        return nil
    end
    def my_uniq
        new_arr = []
        self.each do |ele|
            if !new_arr.include?(ele)
                new_arr << ele
            end
        end
        return new_arr
    end
    def my_transpose
        new_arr = []
        self.each_with_index do |ele, ind|
            ele.each_with_index do |e, i|
                new_arr[i] = [] if new_arr[i].nil?
                new_arr[i][ind] = e
            end
        end
        return new_arr
    end
end
