require_relative "board"
class HumanPlayer
    attr_reader :mark
    def initialize(mark)
        @mark = mark
    end
    def get_position(arr)
        while(true)
            p "Player " + @mark.to_s + 
                ", enter position as two numbers separated with a space"
            input = gets.chomp
            user_num1 = Integer(input[0]) rescue false
            user_num2 = Integer(input[2]) rescue false
            if input.length == 3 && user_num1.is_a?(Integer) && 
                user_num2.is_a?(Integer)
                position = [user_num1, user_num2]
                if arr.include?(position)
                    return position
                    break
                else
                    p "Your choice is illegal"
                end
            else
                p "Incorrect input"
            end
        end
    end
end