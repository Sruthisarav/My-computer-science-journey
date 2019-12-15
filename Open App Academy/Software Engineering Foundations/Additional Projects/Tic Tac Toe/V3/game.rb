require_relative "board.rb"
require_relative "human_player.rb"
require_relative "computer_player.rb"
class Game
    def initialize(n, hash)
        @board = Board.new(n)
        @players = []
        hash.each do |k, v|
            if v
                @players << ComputerPlayer.new(k)
            else
                @players << HumanPlayer.new(k)
            end
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
            legal_pos = @board.legal_positions
            position = @current_player.get_position(legal_pos)
            @board.place_mark(position, @current_player.mark)
            if @board.win?(@current_player.mark)
                p "You have won, " + @current_player.mark.to_s
                return
            else
                self.switch_turn
            end
        end
        p "It is a draw"
    end
end