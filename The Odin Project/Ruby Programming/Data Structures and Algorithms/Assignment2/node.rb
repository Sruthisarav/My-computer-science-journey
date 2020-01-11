class Node
    attr_reader :position, :parent, :children
    def initialize(position, parent=nil)
        @position = position
        @parent = parent
        @children = []
    end
    def valid_move?(pos)
        return true if pos[0] >= 0 && pos[0] < 8 && pos[1] >= 0 && pos[1] < 8
        return false
    end
    def create_children(list_of_pos)
        moves = [[1, 2], [2, 1], [2, -1], [1, -2], 
        [-1, 2], [-2, 1], [-2, -1], [-1, -2]]
        moves.each do |move|
            new_pos = [@position[0]+move[0], @position[1]+move[1]]
            if !list_of_pos.include?(new_pos) && valid_move?(new_pos)
                new_child = Node.new(new_pos, self)
                @children << new_child 
            end
        end
    end
end