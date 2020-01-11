require_relative 'hangman.rb'
require_relative 'player.rb'
require 'yaml'
class Game
    def initialize
        self.beginning
        self.start if !self.saved_game?
    end
    def beginning
        h = Hangman.new
        @secret_word = h.create_secret_word.downcase
        @tries = 10
        @incorrect = []
        @correct = []
        @player = Player.new
        @saved = false
    end
    def display
        guess = ''
        @secret_word.each_char do |char|
            if @correct.include?(char)
                guess += "#{char} "
            else
                guess += '_ '
            end
        end
        return guess
    end
    def over?
        return true if @tries == 0 || !display.split('').include?('_')
        return true if @saved
        return false
    end
    def save_progress(name)
        Dir.mkdir("saved_files") unless Dir.exists? "saved_files"
        saved = File.open("saved_files/#{name}.yaml","w")
        saved.write(YAML.dump(self))
        saved.close
        @saved = true
    end
    def get_saved_file(name)
        fname = "saved_files/#{name}.yaml"
        if File.exists?(fname) 
            contents = File.open(fname, "r") {|file| file.read}
            hangman = YAML.load(contents)
            hangman.start
            return true
        else
            puts "File does not exist."
            return self.saved_game?
        end
    end
    def saved_game?
        valid = false
        while(!valid)
            puts "Would you like to continue a saved game? Type y or n"
            input = gets.chomp.downcase
            valid = @player.yes_or_no?(input)
        end
        if input == 'y'
            name = @player.get_saved_fname
            return get_saved_file(name)
        end
        return false
    end
    def round
        need_to_save = @player.save_game? 
        if need_to_save == 'y'
            name = @player.get_name
            save_progress(name)
        else
            puts "You have #{@tries} tries left."
            input = @player.guess(@correct, @incorrect)
            @tries -= 1
            if @secret_word.include?(input)
                @correct << input
                puts "You have made a correct guess!"
            else
                @incorrect << input
                puts "You have made an incorrect guess!"
            end
        end
    end
    def restart
        valid = false
        while(!valid)
            puts "Would you like to play again? Type y or n"
            input = gets.chomp
            valid = @player.yes_or_no?(input)
        end
        if input == 'y'
            Game.new
        else
            return
        end
    end
    def start
        over = false
        while(!over)
            puts "Here's the secret word: #{display}"
            print "Your guesses: "
            @incorrect.each {|char| print "#{char} "}
            @correct.each {|char| print "#{char} "}
            print "\n"
            round
            over = over?
        end
        if !@saved
            if display.split('').include?('_')
                puts "You have lost!"
                puts "The secret word was: #{@secret_word}" 
            else
                puts "Congrats, you have won!"
            end
        end
        self.restart
    end
end