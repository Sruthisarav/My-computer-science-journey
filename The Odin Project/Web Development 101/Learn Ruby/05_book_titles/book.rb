class Book
    attr_writer :title
    def title
        new_title = []
        exclude = ['and', 'in', 'the', 'of', 'a', 'an']
        @title.split(' ').each_with_index do |word, i|
            if exclude.include?(word) && i > 0
                new_title << word 
            else 
                new_title << word.capitalize() 
            end
        end
        return new_title.join(' ')
    end
end
