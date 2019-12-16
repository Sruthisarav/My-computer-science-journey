require_relative 'player.rb'
require 'set'

class Game
    attr_reader :fragment
    def initialize(*names)
        @players = []
        names.each do |name|
            @players << Player.new(name)
        end
        @live_players = @players
        @game = true
        @current_player = @live_players[0]
        @previous_players = @live_players
        @fragment = ""
        @dictionary = Set.new(File.readlines("dictionary.txt").map { |word| word.chomp } )
        @losses = {}
        @players.each do |player|
            @losses[player] = 0
        end
    end
    def end_game
        p "You have ended the game."
        @game = false
    end
    def next_player!
        @live_players = @live_players.rotate(1)
        @current_player = @live_players[0]
    end
    def valid_play?(string)
        alphabets = 'abcdefghijklmnopqrstuvwxyz'
        return false if !alphabets.include?(string)
        return true if (@fragment+string).length == 1
        return @dictionary.any? do |word| 
            (@fragment+string) == word[0..@fragment.length]
        end
    end
    def take_turn(player)
        valid = false
        while(!valid)
            input = player.guess
            if input == "quit"
                end_game
                return
            end
            valid = valid_play?(input)
            player.alert_invalid_guess if !valid
        end
        @fragment += input
        p "Current fragment: " + @fragment
    end
    def play_round
        take_turn(@current_player)
        if @dictionary.include?(@fragment)
            p "You have lost, " + @current_player.name
            @losses[@current_player] += 1
        elsif !@game
            return
        else
            next_player!
            play_round
        end
    end
    def record(player)
        loss = @losses[player]
        ghost = "GHOST"
        return ghost.slice(0, loss)
    end
    def display_standings
        @losses.each do |k, v|
            p k.name + " has the letters: " + record(k)
        end
    end
    def update
        @previous_players = @live_players
        @live_players = []
        @previous_players.each do |player|
            @live_players << player if @losses[player] < 5
        end
        @current_player = @live_players[0]
        next_player! if @previous_players.length == @live_players.length
    end
    def run
        while(true)
            display_standings
            @fragment = ""
            play_round
            update
            break if @live_players.length == 1 || @game == false
        end
    end
end
