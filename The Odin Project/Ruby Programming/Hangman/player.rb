class Player
    def initialize
        @@alphabets = 'abcdefghijklmnopqrstuvwxy'
    end
    def valid_play(guesses, input)
        return false if !@@alphabets.include?(input)
        return false if guesses.include?(input)
        return true
    end
    def yes_or_no?(input)
        return true if input == 'y' or input == 'n'
    end
    def guess(correct, incorrect)
        valid = false
        while(!valid)
            puts "What is your next guess? "
            input = gets.chomp.downcase
            valid = valid_play(correct + incorrect, input)
            puts "Invalid guess" if !valid
        end
        return input
    end
    def save_game?
        valid = false
        while(!valid)
            puts "Would you like to save the game? Type y or n"
            input = gets.chomp.downcase
            valid = yes_or_no?(input)
        end
        return input
    end
    def get_name
        puts "What would you like to name the file as?"
        input = gets.chomp
    end
    def get_saved_fname
        puts "What is the name of the saved game?"
        input = gets.chomp
    end
end