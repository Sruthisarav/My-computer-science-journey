class ComputerPlayer
    attr_reader :mark
    def initialize(mark)
        @mark = mark
    end
    def get_position(arr)
        random_num = rand(arr.length)
        position = arr[random_num]
        p "Computer " + @mark.to_s + " chose position " + position.to_s
        return position
    end

end