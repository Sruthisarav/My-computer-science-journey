class GuessingGame
    def initialize(min, max)
        @secret_num = rand(min..max)
        @num_attempts = 0
        @game_over = false
    end
    def num_attempts
        return @num_attempts
    end
    def game_over?
        return @game_over
    end
    def check_num(n)
        @num_attempts+= 1
        if n == @secret_num
            @game_over = true
            p "you win"
        elsif n > @secret_num
            p "too big"
        else
            p "too small"
        end
    end
    def ask_user
        p "enter a number"
        response = gets.chomp.to_i
        check_num(response)
    end

end
