class Board
    attr_reader :size
    def initialize(n)
        @size = n
        @grid = []
        (0...n).each do |i|
            @grid[i] = []
            (0...n).each do |j|
                @grid[i][j] = '_'
            end
        end
    end
    def valid?(position)
        return true if position[0] >= 0 && position[0] < @size &&
            position[1] >= 0 && position[1] < @size
        return false
    end
    def empty?(position)
        return @grid[position[0]][position[1]] == '_'
    end
    def place_mark(position, mark)
        if valid?(position) && empty?(position)
            @grid[position[0]][position[1]] = mark
        else
            raise "invalid mark"
        end
    end
    def print
        @grid.each do |row|
            p row
        end
    end
    def win_row?(mark)
        @grid.each do |row|
            bool = true
            row.each do |ele|
                bool = false if ele != mark
            end
            return true if bool
        end
        return false
    end
    def win_col?(mark)
        (0...@size).each do |n|
            bool = true
            @grid.each do |row|
                bool = false if row[n] != mark
            end
            return true if bool
        end
        return false
    end
    def win_diagonal?(mark)
        bool = true
        (0...@size).each do |n|
            bool = false if @grid[n][n] != mark
        end
        return true if bool
        bool = true
        (0...@size).each do |n|
            bool = false if @grid[n][@size-1-n] != mark
        end
        return bool
    end
    def win?(mark)
        return win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end
    def empty_positions?
        @grid.each do |row|
            return true if row.any? {|ele| ele == "_"}
        end
        return false
    end
end
