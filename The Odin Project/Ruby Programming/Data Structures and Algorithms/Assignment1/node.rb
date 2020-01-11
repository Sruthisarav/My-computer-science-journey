class Node
    attr_accessor :left, :right
    attr_reader :data
    def initialize(data, left=nil, right=nil)
        @data = data
        @left = left
        @right = right
    end

end