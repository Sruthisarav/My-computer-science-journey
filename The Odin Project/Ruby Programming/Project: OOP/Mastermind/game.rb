require_relative 'board.rb'
require_relative 'human_player.rb'
require_relative 'computer_player.rb'
class Game
    def initialize
        @@turns = 12
        @player = HumanPlayer.new
        @board = []
        @computer = ComputerPlayer.new
        @feedback = []
        self.start
    end
    def game_over?(feedback)
        return [true, false] if @@turns == 0 
        return [true, true] if feedback == ['B', 'B', 'B', 'B']
        return [false, nil]
    end
    def start
        puts "Do you want to play as 'Code Breaker' or 'Code Maker'?"
        input = gets.chomp
        if input == "Code Breaker"
            self.code_breaker
        elsif input == "Code Maker"
            self.code_maker
        else
            start
        end
    end
    def print_feedback
        print "Feedback: "
        @feedback.each {|ele| print "#{ele} "}
        puts ""
    end
    def code_breaker
        @board = Board.new
        puts "You have 12 tries to guess the secret code."
        puts "The list of possible colors: 'R', 'O', 'Y', 'G', 'I', 'P'."
        puts "The feedback will contain an array of 'W' or 'B'."
        over = false
        while (!over)
            move = @player.your_move
            @@turns -= 1
            @feedback = @board.feedback(move)
            print_feedback
            result = self.game_over?(@feedback)
            over = result[0]
        end
        puts result[1] ? "You have won!" : "You have lost!"
    end
    def code_maker
        puts "The list of possible colors: 'R', 'O', 'Y', 'G', 'I', 'P'."
        code = @player.your_code
        @board = Board.new(code)
        over = false
        while(!over)
            move = @computer.your_move(code, @feedback)
            print "Computer's move: "
            move.each do |ele|
                print "#{ele} "
            end
            puts ""
            @@turns -= 1
            @feedback = @board.feedback(move)
            print_feedback
            result = self.game_over?(@feedback)
            over = result[0]
        end
        puts result[1] ? "Computer has won!" : "You have won!"
    end
end
