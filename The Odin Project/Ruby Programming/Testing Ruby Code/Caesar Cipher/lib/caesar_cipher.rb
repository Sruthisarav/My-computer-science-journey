def caesar_cipher(sentence, shift)
    lower_alphabets = 'abcdefghijklmnopqrstuvwxyz'
    upper_alphabets = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    encrypted = ''
    sentence.each_char do |char|
        if lower_alphabets.include?(char)
            char_index = (lower_alphabets.index(char) + shift) % 26
            encrypted += lower_alphabets[char_index]
        elsif upper_alphabets.include?(char)
            char_index = (upper_alphabets.index(char) + shift) % 26
            encrypted += upper_alphabets[char_index]
        else
            encrypted += char
        end
    end
    return encrypted
end

p caesar_cipher("What a string!", 5)