class Card
    attr_reader :face_up
    def initialize(face_value)
        @face_up = false
        @face_value = face_value
    end
    def hide
        @face_up = false
    end
    def reveal
        @face_up = true
    end
    def to_s
        return @face_value if @face_up
        return " "
    end
    def ==(card)
        return self == card
    end
end