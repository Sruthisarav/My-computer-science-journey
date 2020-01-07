#write your code here
def translate(sentence)
    words = sentence.split(' ')
    vowels = 'aeio'
    newWords = []
    words.each do |word|
        if vowels.include?(word[0].downcase)
            newWords << word + "ay"
        else
            i = 1
            while(!vowels.include?(word[i].downcase))
                i += 1
            end
            newWords << word[i..-1] + word[0...i] + "ay"
        end
    end
    return newWords.join(' ')
end