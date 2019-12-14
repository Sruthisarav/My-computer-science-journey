class Player
    def get_move
        p "enter a position with coordinates separated with a space like '4 7'"
        input = gets.chomp
        return [input[0].to_i, input[2].to_i]
    end
end
