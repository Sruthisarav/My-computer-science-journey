class Hangman
    def initialize(min=5, max=12)
        file = File.open("5desk.txt")
        dictionary = file.readlines.map(&:chomp)
        file.close
        @@dictionary = dictionary.select do |word| 
            word.length >= min && word.length <= max
        end
    end
    def create_secret_word
        index = rand(@@dictionary.length)
        return @@dictionary[index]
    end
end