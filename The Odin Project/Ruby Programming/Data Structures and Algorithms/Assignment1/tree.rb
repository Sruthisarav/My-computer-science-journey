require_relative 'node.rb'
class Tree
    def initialize(arr)
        @root = build_tree(arr)
    end
    def build_tree(arr)
        return nil if arr.length == 0
        arr = arr.sort.uniq
        half = arr.length/2
        head = Node.new(arr[half])
        return head if arr.length == 1
        head.right = build_tree(arr[half+1..-1])
        head.left = build_tree(arr[0...half])
        return head
    end
    def insert(value)
        node = Node.new(value)
        current = @root
        inserted = false
        while(!inserted)
            if current.data > value 
                if current.right == nil
                    current.right = node
                    inserted = true
                else
                    current = current.right
                end
            else
                if current.left == nil
                    current.left = node
                    inserted = true
                else
                    current = current.left
                end
            end
        end
    end
    def delete(value)
        current = @root
        prev = ''
        while(current.data != value)
            prev = current
            current = current.right if value > current.data 
            current = current.left if value < current.data
        end
        if current.left == nil && current.right == nil
            current = nil
        elsif value < prev
            temp = current.right
            current = current.left
            while(current.right != nil)
                current = current.right
            end
            current.right = temp
        else
            temp = current.left
            current = current.right
            while(current.left != nil)
                current = current.left
            end
            current.left = temp
        end  
    end
    def find(value)
        current = self
        while(current.data != value)
            prev = current
            current = current.right if value > current.data 
            current = current.left if value < current.data
        end
        return current
    end
    def level_order
        return if @root == nil
        queue = [@root]
        while (queue.length != 0)
            queue << queue[0].left if queue[0].left != nil
            queue << queue[0].right if queue[0].right != nil
            yield(queue[0].data)
            queue.shift()
        end
    end
    def inorder(node=@root, &blk)
        define_method(node, 'in', &blk)
    end
    def preorder(node=@root, &blk)
        define_method(node, 'pre', &blk)
    end
    def postorder(node=@root, &blk)
        define_method(node, 'post', &blk)
    end
    def define_method(node=@root, order, &blk)
        return if node == nil
        blk.call(node.data) if order == 'pre'
        define_method(node.left, order, &blk)
        blk.call(node.data) if order == 'in'
        define_method(node.right, order, &blk)
        blk.call(node.data) if order == 'post'
    end
    def depth(node)
        return 0 if node == nil
        return 1 if node.left == 0 && node.right == 0
        left = depth(node.left)
        right = depth(node.right)
        return left + 1 if left >= right
        return right + 1 if right > left
    end
    def balanced?
        return true if @root == nil || (@root.left == 0 && @root.right == 0)
        left = depth(@root.left) 
        right = depth(@root.right)
        return true if left - right >= -1 && left - right <= 1
        return false
    end
    def rebalance!
        arr_of_values = []
        self.level_order {|value| arr_of_values << value}
        @root = build_tree(arr_of_values)
    end
end