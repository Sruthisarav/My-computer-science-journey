require_relative 'node.rb'
class LinkedList
    attr_accessor :name
    def initialize(data)
        @head = Node.new(data)
        @tail = @head
        @@size = 1
    end
    def append(data)
        node = Node.new(data)
        @tail.next_node = node
        @tail = node
        @@size += 1
    end
    def prepend(data)
        node = Node.new(data)
        node.next_node = @head
        @head = node
        @@size += 1
    end
    def size
        return @@size
    end
    def head
        return @head
    end
    def tail
        return @tail
    end
    def at(index)
        return nil if index >= @@size
        count = 0
        current = @head
        while(count != index)
            current = current.next_node
            count += 1
        end
        return current
    end
    def pop
        @@size -= 1
        if @@size <= 0
            @head = nil
            @tail = nil
            return
        end
        count = 0
        current = @head
        while(count != @@size-1)
            current = current.next_node
            count += 1
        end
        current.next_node = nil
        @tail = current
    end
    def contains?(data)
        current = @head
        while (current != nil)
            return true if current.value == data
            current = current.next_node
        end
        return false
    end
    def find(data)
        count = 0
        current = @head
        while(current!=nil)
            return count if current.value == data
            current = current.next_node
            count += 1
        end
        return nil
    end
    def to_s
        current = @head
        while(current != nil)
            print "( #{current.value} ) -> "
            current = current.next_node
        end
        print "nil\n"
    end
end

#tests
l = LinkedList.new('B')
l.append('C')
l.prepend('A')
p l.size
p l.contains?('B')
p l.contains?('G')
p l.find('A')
p l.find('G')
l.append('D')
l.append('E')
l.to_s

l.pop
l.to_s

l.pop
l.pop
l.pop
l.pop
l.to_s