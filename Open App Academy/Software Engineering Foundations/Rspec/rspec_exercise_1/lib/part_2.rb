def hipsterfy(word)
    vowels = 'aeiou'
    new_str = ''
    len = word.length
    (0..len - 1).each do |n|
        if (vowels.include?(word[len-1 - n]))
            new_str = word[0, len-1 - n] + new_str
            break
        else
            new_str = word[len-1-n] + new_str
        end
    end
    return new_str
end

def vowel_counts(str)
    vowels = 'aeiou'
    hash = Hash.new(0)
    str = str.downcase
    str.each_char do |char|
        if (vowels.include?(char))
            hash[char] += 1
        end
    end
    return hash
end

def caesar_cipher(message, n)
    alphabets_low = ('a'..'z').to_a.join 
    alphabets_up = ('A'..'Z').to_a.join
    cipher_low = alphabets_low.chars.rotate(n).join
    cipher_up= alphabets_up.chars.rotate(n).join
    cipher = ''
    message.each_char do |char|
        if cipher_low.include?(char)
            cipher += cipher_low[alphabets_low.index(char)]
        elsif cipher_up.include?(char)
            cipher += cipher_up[alphabets_up.index(char)]
        else 
            cipher += char
        end
    end
    return cipher
end