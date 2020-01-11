require_relative 'node.rb'
class Board
    def initialize
    end
    def search_path(node)
        path = [node.position]
        pos = node.parent
        while(pos != nil)
            path = [pos.position] + path
            pos = pos.parent
        end
        return path
    end
    def knight_moves(start_pos, end_pos)
        start = Node.new(start_pos)
        queue = [start]
        list_of_pos = [start.position]
        while(true)
            current = queue.shift
            if current.position == end_pos
                path = search_path(current)
                display(path)
                break
            else
                current.create_children(list_of_pos)
                children = current.children
                children.each do |child|
                    queue << child
                    list_of_pos << child.position
                end
            end
        end
    end
    def display(path)
        puts "You made it in #{path.length} moves! Here's your path:"
        path.each {|pos| print "#{pos}\n"}
    end
end

b = Board.new
b.knight_moves([3,3],[4,3])