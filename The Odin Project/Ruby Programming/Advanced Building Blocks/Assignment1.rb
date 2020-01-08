def bubble_sort(arr)
    swapped = true
    while (swapped)
        swapped = false
        arr[0...-1].each_with_index do |num, i|
            if num > arr[i+1]
                arr[i], arr[i+1] = arr[i+1], arr[i]
                swapped = true
            end
        end
    end
    return arr
end

p bubble_sort([4,3,78,2,0,2])

def bubble_sort_by(arr)
    swapped = true
    while (swapped)
        swapped = false
        arr[0...-1].each_with_index do |num, i|
            if yield(arr[i], arr[i+1]) > 0
                arr[i], arr[i+1] = arr[i+1], arr[i]
                swapped = true
            end
        end
    end
    return arr
end 
p bubble_sort_by(["hi","hello","hey"]) {|left,right| left.length - right.length}