def substrings(sentence, valid_words)
    hash = Hash.new(0)
    words = sentence.split(' ')
    words.each do |word|
        word = word.downcase()
        valid_words.each do |valid_word|
            if word.include?(valid_word)
                hash[valid_word] += 1
            end
        end
    end
    return hash
end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
p substrings("Howdy partner, sit down! How's it going?", dictionary)