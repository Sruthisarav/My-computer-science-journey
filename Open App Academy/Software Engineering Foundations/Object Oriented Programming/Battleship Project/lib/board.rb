class Board
    attr_reader :size
    def initialize(n)
        @grid = Array.new(n) { Array.new(n, :N) }
        @size = n * n
    end
    def [](position)
        return @grid[position[0]][position[1]]
    end
    def []= (position, value)
        @grid[position[0]][position[1]] = value
    end
    def num_ships
        count = 0
        @grid.each {|row| row.each {|e| count += 1 if e == :S}}
        return count
    end
    def attack(position)
        if self[position] == :S
            self[position]= :H
            p "you sunk my battleship!"
            return true
        else 
            self[position] = :X
            return false
        end
    end
    def place_random_ships
        positions = []
        len = @grid.length
        num = size/4
        count = 0
        while (count != num)
            position = [rand(0...len), rand(0...len)]
            if !positions.include?(position)
                self[position]= :S
                positions << position
                count += 1
            end
        end
    end
    def hidden_ships_grid
        return @grid.map {|row| row.map do |ele| 
                if ele == :S
                    :N
                else
                    ele
                end
            end }
    end
    def self.print_grid(grid)
        grid.each_with_index do |row, ind|
            row.each_with_index do |ele, i|
                print " " if i != 0
                print ele 
            end
            print "\n"
        end
    end
    def cheat
        Board.print_grid(@grid)
    end
    def print
        Board.print_grid(hidden_ships_grid)
    end
end
