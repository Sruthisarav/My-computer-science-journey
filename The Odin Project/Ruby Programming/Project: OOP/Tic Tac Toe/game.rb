require_relative 'player.rb'
require_relative 'board.rb'
class Game
    def initialize(name1, mark1, name2, mark2)
        player1 = Player.new(name1, mark1)
        player2 = Player.new(name2, mark2)
        @@moves = 0
        @players = [player1, player2]
        @current_player = @players[0]
        @board = Board.new
        self.start
    end
    def valid_move?(move)
        return false if move.include?(nil) || move[0] > 2 || move[1] > 2 || move[0] < 0 || move[1] < 0
        return @board.check_move(move)
    end
    def over?
        return false if @@moves < 3
        result = @board.check_game
        if !result
            if @@moves == 9 
                return [true, nil]
            else
                return false
            end
        else
            return result
        end
    end
    def round
        valid = false
        while (!valid)
            move = @current_player.move
            valid = self.valid_move?(move)
            puts "Invalid move" if !valid
        end
        @@moves += 1
        @board.update(move, @current_player.mark)
        @players[0], @players[1] = @players[1], @players[0]
        @current_player = @players[0]
    end
    def find_winner(mark)
        @players.each {|player| return player if player.mark == mark}
    end
    def start
        over = false
        @board.display
        while (!over)
            self.round
            @board.display
            result = self.over?
            unless result
                over = false
            else
                over = true
                winner_mark = result[1]
            end
        end
        puts "Game over!"
        if winner_mark == nil
            puts "It's a draw"
        else
            winner = self.find_winner(winner_mark)
            puts "#{winner.name} has won!"
        end
    end
end