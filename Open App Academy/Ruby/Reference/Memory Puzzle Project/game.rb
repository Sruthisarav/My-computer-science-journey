require_relative 'board.rb'
require_relative 'humanplayer.rb'
require_relative 'computerplayer.rb'
class Game
    def initialize(player=false)
        if !player
            @player = HumanPlayer.new()
        else
            @player = ComputerPlayer.new()
        end
        @computer = player
        @board = Board.new()
        @prev_guess = nil
        @guessed_pos = nil
        @size = @board.size
    end
    def play
        @board.populate
        @board.render
        while(!over?)
            pos = @player.prompt(nil)
            make_guess(pos)
            display
            make_guess(@player.prompt(@prev_guess))
            display
        end
        print "You have won the game!"
    end
    def over?
        return @board.won?
    end
    def make_guess(pos)
        if @prev_guess.nil?
            val = @board.reveal(pos)
            @player.receive_revealed_card(pos, val) if @computer
            @prev_guess = pos
        else
            @guessed_pos = pos
            val = @board.reveal(pos)
            @player.receive_revealed_card(pos, val) if @computer
            if val != @board.reveal(@prev_guess)
                display
                sleep(2)
                @board.hide(@prev_guess)
                @board.hide(pos)
            else
                @player.receive_match(@guessed_pos, @prev_guess) if @computer
            end
            @prev_guess = nil
        end
    end
    def display
        system("clear")
        @board.render
    end
end