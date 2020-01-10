def merge_sort(arr)
    return arr if arr.length <= 1
    half = arr.length/2
    first_half = merge_sort(arr[0...half])
    second_half = merge_sort(arr[half..-1])
    sorted = []
    while (sorted.length != arr.length)
        if first_half.empty?
            sorted += second_half
        elsif second_half.empty?
            sorted += first_half
        elsif first_half[0] <= second_half[0]
            sorted << first_half[0]
            first_half.shift()
        else
            sorted << second_half[0]
            second_half.shift()
        end
    end
    return sorted
end

p merge_sort([2, 1])
p merge_sort([5, 9, 2, 100, 51, 67, 31])