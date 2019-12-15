require_relative "board"
class HumanPlayer
    attr_reader :mark
    def initialize(mark)
        @mark = mark
    end
    def get_position
        p "Enter position as two numbers separated with a space"
        input = gets.chomp
        user_num1 = Integer(input[0]) rescue false
        user_num2 = Integer(input[2]) rescue false
        if input.length == 3 && user_num1.is_a?(Integer) && 
            user_num2.is_a?(Integer)
            position = [user_num1, user_num2]
        else
            raise "incorrect input"
        end
    end
end