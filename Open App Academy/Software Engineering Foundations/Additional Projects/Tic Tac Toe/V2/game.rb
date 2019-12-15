require_relative "board.rb"
require_relative "human_player.rb"
class Game
    def initialize(n, *marks)
        @board = Board.new(n)
        @players = []
        marks.each do |mark|
            @players << HumanPlayer.new(mark)
        end
        @current_player = @players[0]
    end
    def switch_turn
        @players = @players.rotate(1)
        @current_player = @players[0]
    end
    def play
        while(@board.empty_positions?)
            @board.print
            position = @current_player.get_position
            @board.place_mark(position, @current_player.mark)
            if @board.win?(@current_player.mark)
                p "You have won, player with the mark: " + @current_player.mark
            else
                self.switch_turn
            end
        end
        p "It is a draw"
    end
end