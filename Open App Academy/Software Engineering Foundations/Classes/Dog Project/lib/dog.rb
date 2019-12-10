class Dog
    def initialize(name, breed, age, bark, favorite_foods)
        @name = name
        @breed = breed
        @age = age
        @bark = bark
        @favorite_foods = favorite_foods
    end
    def name
        return @name
    end
    def breed
        return @breed
    end
    def age
        return @age
    end
    def age= (number)
        @age = number
    end
    def bark
        if @age > 3
            return @bark.upcase
        else
            return @bark.downcase
        end
    end
    def favorite_foods
        return @favorite_foods
    end
    def favorite_food?(food)
        favorite_foods.each do |ele|
            if (ele.downcase == food.downcase)
                return true
            end
        end
        return false
    end
end
