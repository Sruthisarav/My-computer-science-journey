class HumanPlayer
    def initialize()
        @name = 'Human'
    end
    def prompt(prev_guess)
        print "Please enter the position of the card you'd like to flip." 
        print "\n"
        input = gets.chomp
        x = Integer(input[0]) rescue nil
        y = Integer(input[2]) rescue nil
        if input.length != 3 || x.nil? || y.nil? || x> 3 || y > 3
            p "Incorrect input. please try again"
            return prompt(prev_guess)
        end
        return [x, y]
    end
end