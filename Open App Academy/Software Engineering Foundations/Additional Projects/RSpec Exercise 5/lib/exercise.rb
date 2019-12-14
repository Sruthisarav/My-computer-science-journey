def zip(*args)
    len = args[0].length
    newArr = []
    (0...len).each do |i|
        newArr[i] = []
        args.each { |arr| newArr[i] << arr[i] }
    end
    return newArr
end

def prizz_proc(arr, prc1, prc2)
    newArr = []
    arr.each do |ele|
        if prc1.call(ele) && !prc2.call(ele) ||
            !prc1.call(ele) && prc2.call(ele)
            newArr << ele
        end
    end
    return newArr
end

def zany_zip(*args)
    len = args[0].length
    args.each {|arr| len = arr.length if arr.length > len}
    newArr = []
    (0...len).each do |i|
        newArr[i] = []
        args.each do |arr| 
            if arr[i].nil?
                newArr[i] << nil
            else
                newArr[i] << arr[i] 
            end
        end
    end
    return newArr
end

def maximum(arr, &prc)
    return nil if arr.empty?
    element = arr[0]
    result = prc.call(arr[0])
    arr.each do |ele|
        if prc.call(ele) >= result
            result = prc.call(ele)
            element = ele
        end
    end
    return element
end

def my_group_by(arr, &prc)
    hash = Hash.new {|h, k| h[k] = []}
    arr.each do |ele|
        hash[prc.call(ele)] << ele
    end
    return hash
end

def max_tie_breaker(arr, prc1, &prc2)
    return nil if arr.empty?
    element = arr[0]
    result = prc2.call(arr[0])
    arr.each do |ele|
        blc = prc2.call(ele)
        if blc > result
            element = ele
            result = blc
        elsif blc == result
            if prc1.call(ele) > prc1.call(element)
                element = ele
                result = blc
            end
        end
    end
    return element
end

def silly_syllables(sentence)
    vowels = "aeiou"
    words = sentence.split(" ")
    words.each_with_index do |word, index|
        positions = []
        word.each_char.with_index do |char, i|
            positions << i if vowels.include?(char)
        end
        if positions.length >= 2
            newWord = ""
            word.each_char.with_index do |char, i|
                if(i >= positions[0] && i <= positions[-1])
                    newWord += char
                end
            end
            words[index] = newWord
        end
    end
    return words.join(" ")
end
            