class Board
    def initialize(board=[])
        @@colors = ['R', 'O', 'Y', 'G', 'I', 'P']
        @board = board
        if board.empty?
            for i in 0...4 do
                index = rand(6)
                @board << @@colors[index]
            end
        end
    end
    def feedback(guess)
        fb = []
        not_guessed = @board.dup
        wrong_guesses = []
        guess.each_with_index do |color, index|
            if @board[index] == color
                not_guessed.delete_at(index - fb.length)
                fb << ['B', index]
            else
                wrong_guesses << color
            end
        end
        wrong_guesses.each do |color|
            if not_guessed.include?(color)
                fb << ['W']
                not_guessed.delete_at(not_guessed.index(color))
            end
        end
        fb = fb.shuffle
        return fb.map {|arr| arr[0]}
    end
end
