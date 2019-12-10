# Reimplement the bubble sort outlined in the preceding lecture.
# The bubble_sort method should accept an array of numbers and arrange the elements in increasing order.
# The method should return the array.
# Do not use the built-in Array#sort

def bubble_sort(arr)
    changes = true
    while changes
        changes = false
        (1..arr.length-1).each do |n|
            if arr[n] < arr[n-1]
                arr[n-1], arr[n] = arr[n], arr[n-1]
                changes = true
            end
        end
    end
    return arr
end

p bubble_sort([2, 8, 5, 2, 6])      # => [2, 2, 5, 6, 8]
p bubble_sort([10, 8, 7, 1, 2, 3])  # => [1, 2, 3, 7, 8, 10]