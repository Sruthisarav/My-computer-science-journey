class Room
    def initialize(capacity)
        @capacity = capacity
        @occupants = []
    end
    def capacity
        return @capacity
    end
    def occupants 
        return @occupants
    end
    def full?
        return @occupants.length == @capacity
    end
    def available_space
        return @capacity - @occupants.length
    end
    def add_occupant(name)
        if full?
            return false
        else
            @occupants << name
            return true
        end
    end
end
