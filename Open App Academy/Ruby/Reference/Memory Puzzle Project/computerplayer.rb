class ComputerPlayer
    def initialize()
        @known_cards = Hash.new {|h, k| h[k] = []}
        @matched_cards = []
        @unmatched_cards = []
        (0..3).each do |i|
            (0..3).each {|j| @unmatched_cards << [i, j] }
        end
    end
    def prompt(prev_guess)
        if prev_guess.nil?
            @known_cards.each do |k, v|
                if v.length == 2 && !@matched_cards.include?(v[0])
                    return v[0]
                end
            end
            pos = @unmatched_cards.sample()
            print pos
            sleep(1)
            return pos
        else
            val = nil
            @known_cards.each do |k, v|
                val = k if v.include?(prev_guess)
            end 
            if !val.nil? && @known_cards[val].length == 2
                if prev_guess != @known_cards[val][0]
                    pos= @known_cards[val][0] 
                else
                    pos = @known_cards[val][1]
                end
            else
                pos = prev_guess
                while(pos.equal?(prev_guess))
                    pos = @unmatched_cards.sample
                end
            end
            print pos
            sleep(1)
            return pos
        end
    end
    def receive_revealed_card(pos, value)
        @known_cards[value] << pos if !@known_cards[value].include?(pos)
    end
    def receive_match(pos1, pos2)
        @matched_cards << pos1
        @matched_cards << pos2
        @unmatched_cards.delete(pos1)
        @unmatched_cards.delete(pos2)
    end
end