class ComputerPlayer
    def initialize
        @@colors = ['R', 'O', 'Y', 'G', 'I', 'P']
        @final = ['-', '-', '-', '-']
        @prev_moves = []
        @prev_move = []
    end
    def your_move(answer, feedback)
        possible_guesses = []
        if feedback.include?('W')
            @prev_move.each_with_index do |color, index|
                possible_guesses << color if @final[index] != color
            end
        end
        move = []
        for i in 0...4 do
            if @final[i] != '-'
                move << @final[i]
            else
                if possible_guesses.length == 0
                    index = Random.rand(1..6) - 1
                    color = @@colors[index]
                    @final[i] = color if color == answer[i]
                    move << color
                else
                    index = Random.rand(1..possible_guesses.length) - 1
                    color = possible_guesses[index]
                    possible_guesses.delete(color)
                    @final[i] = color if color == answer[i]
                    move << color
                end
            end
        end
        if @prev_moves.include?(move)
            return your_move(answer, feedback)
        else
            @prev_moves << move
            @prev_move = move
            return move
        end
    end
end