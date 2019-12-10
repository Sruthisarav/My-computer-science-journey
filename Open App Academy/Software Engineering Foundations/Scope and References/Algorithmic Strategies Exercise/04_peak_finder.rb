# Write a method, peak_finder(arr), that accepts an array of numbers as an arg.
# The method should return an array containing all of "peaks" of the array.
# An element is considered a "peak" if it is greater than both it's left and right neighbor.
# The first or last element of the array is considered a "peak" if it is greater than it's one neighbor.

def peak_finder(arr)
    peak = []
    len = arr.length
    if arr[0] > arr[1]
        peak.push(arr[0])
    end
    (1..len-2).each do |n|
        if arr[n] > arr[n-1] and arr[n] > arr[n+1]
            peak.push(arr[n])
        end
    end
    if arr[len-1] > arr[len-2]
        peak.push(arr[len-1])
    end
    return peak
end

p peak_finder([1, 3, 5, 4])         # => [5]
p peak_finder([4, 2, 3, 6, 10])     # => [4, 10]
p peak_finder([4, 2, 11, 6, 10])    # => [4, 11, 10]
p peak_finder([1, 3])               # => [3]
p peak_finder([3, 1])               # => [3]
