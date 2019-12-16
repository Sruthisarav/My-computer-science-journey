class Player
    attr_reader :name
    def initialize(name)
        @name = name
    end
    def guess
        p "Please enter a valid alphabet, " + @name
        input = gets.chomp
        return input
    end
    def alert_invalid_guess
        p "Your guess is invalid, " + @name
    end
end