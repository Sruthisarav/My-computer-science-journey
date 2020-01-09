class Board
    def initialize
        @board = []
        for i in 0..2 do
            @board[i] = [] 
            for j in 0..2 do
                @board[i][j] = '-'
            end
        end
    end
    def display
        @board.each_with_index do |row, i|
            puts '---------'
            row.each do |ele|
                print "|#{ele}|"
            end
            puts ''
            puts '---------' if i == 2
        end
    end
    def check_move(move)
        return @board[move[0]][move[1]] == '-'
    end
    def update(move, mark)
        @board[move[0]][move[1]] = mark
    end
    def check_vert
        for i in 0..2 do
            same = true
            mark = @board[0][i]
            for j in 1..2 do
                same = same && mark == @board[j][i]
            end
            return [true, mark] if same && mark != '-'
        end
        return false
    end
    def check_hor
        for i in 0..2 do
            same = true
            mark = @board[i][0]
            for j in 1..2 do
                same = same && mark == @board[i][j]
            end
            return [true, mark] if same && mark != '-'
        end
        return false
    end
    def check_diag
        return [true, @board[1][1]] if @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && @board[1][1] != '-'
        return [true, @board[1][1]] == @board[1][1] && @board[1][1] == @board[2][0] && @board[1][1] != '-'
        return false
    end
    def check_game
        return self.check_vert || self.check_hor || self.check_diag
    end
end
