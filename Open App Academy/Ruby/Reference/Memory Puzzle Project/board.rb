require_relative 'card.rb'

class Board
    attr_reader :size
    def initialize()
        keys = 'ABCDEFGH'
        @size = 3
        @cards = []
        (0..@size*2+1).each do |n|
            2.times {@cards << Card.new(keys[n]) }
        end
        @grid = []
    end
    def populate
        @cards = @cards.shuffle
        (0..@size).each do |i|
            @grid[i] = []
            (0..@size).each do |j|
                @grid[i][j] = @cards[i*4 +j]
            end
        end
    end
    def render
        (0..size).each do |n| 
            print "\t" + " " if n== 0
            print n.to_s + "\t"
        end
        (0..size).each do |i|
            print "\n"
            print i.to_s + "\t"
            (0..size).each do |j|
                print @grid[i][j].to_s + "\t"
            end
        end
        print "\n"
    end
    def won?
        @cards.each do |card|
            return false if card.to_s == " "
        end
        return true
    end
    def reveal(guessed_pos)
        card = @grid[guessed_pos[0]][guessed_pos[1]]
        card.reveal if !card.face_up
        return card.to_s
    end
    def hide(guessed_pos)
        card = @grid[guessed_pos[0]][guessed_pos[1]]
        card.hide if card.face_up
    end
end
