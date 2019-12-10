require_relative "room"

class Hotel
    def initialize(name, hash)
        @name = name
        @rooms = {}
        hash.each do |k, v|
            @rooms[k] = Room.new(v)
        end
    end
    def name
        new_name = @name.split(" ").each do |word|
            word[0] = word[0].upcase
        end
        return new_name.join(" ")
    end
    def rooms
        return @rooms
    end
    def room_exists?(room_name)
        return @rooms.include?(room_name)
    end
    def check_in(person, room_name)
        if room_exists?(room_name)
            if @rooms[room_name].add_occupant(person)
                p "check in successful"
            else
                p "sorry, room is full"
            end
        else
            p "sorry, room does  not exist"
        end
    end
    def has_vacancy?
        @rooms.each do |k, v|
            return true if !v.full?
        end
        return false
    end
    def list_rooms
        @rooms.each do |k, v|
            puts "#{k} : #{v.available_space}"
        end
    end
end
