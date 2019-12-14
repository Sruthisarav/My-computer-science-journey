require_relative "code"

class Mastermind
    def initialize(length)
        @secret_code = Code.random(length)
    end
    def print_matches(code)
        p @secret_code.num_exact_matches(code)
        p @secret_code.num_near_matches(code)
    end
    def ask_user_for_guess
        p "Enter a code:"
        input = gets.chomp
        guess = Code.from_string(input)
        print_matches(guess)
        return true if @secret_code.num_exact_matches(guess) == @secret_code.length
        return false
    end
end
