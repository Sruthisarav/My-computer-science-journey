# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
    # adding a backslash to the string so that the last letter 
    # of the string will be included assuming there's no backslashes 
    # in the given string
    str += '/'
    count = 0
    character = str[0]
    compressed = ''
    str.each_char do |char|
        if (char == character)
            count += 1
        else 
            if count == 1
                compressed += character
            else
                compressed += count.to_s + character
            end
            character = char
            count = 1
        end
    end
    return compressed
end

p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
