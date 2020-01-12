class Player
    attr_reader :mark, :name
    def initialize(name, mark)
        @name = name
        @mark = mark
    end
    def move
        puts "Where do you want to make your next move, #{@name}? Write in the form of: X Y"
        input = gets.chomp
        x = input[0].to_i
        y = input[2].to_i
        return [x, y]
    end
end