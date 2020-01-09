class HumanPlayer
    def initialize
        @@colors = ['R', 'O', 'Y', 'G', 'I', 'P']
    end
    def valid_play?(move)
        move.each {|c| return false if !@@colors.include?(c)}
    end
    def your_move
        valid = false
        while (!valid)
            puts "Please type your move in the form of: A B C D"
            input = gets.chomp
            move = input.split(' ')
            valid = valid_play?(move)
        end
        return move
    end
    def your_code
        valid = false
        while (!valid)
            puts "Please type your secret code in the form of: A B C D"
            input = gets.chomp
            code = input.split(' ')
            valid = valid_play?(code)
        end
        return code
    end
end