class Employee
    attr_reader :name, :title
    def initialize(name, title)
        @name = name
        @title = title
        @earnings = 0
    end
    def pay(n)
        @earnings += n
    end
end
