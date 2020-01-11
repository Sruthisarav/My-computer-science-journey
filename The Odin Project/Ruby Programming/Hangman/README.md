# Hangman

Start game with: Game.new

Instructions on how to play the game:
The game will ask if you would like to continue a saved game, which is the file of a game you had saved previously.
Answer 'n' if you have not saved any files.
Answer 'y' if you would like to play a saved game, and it will ask for the filename. If the file exists, it will load the
previously saved game. And you will continue from where you had left off. If the file does not exist, it will keep asking
if you would ike to play a saved game again.

The game will start by generating a secret word and then displaying the number of blanks, the number of tries you have left
and your guesses every round. It will ask if you would like to save the game before every round
If you type 'y', it will ask you for a file name and save the file under 'saved_files' directory. Then the game will automatically
end and ask if you would to play another game.
If yes, the game will restart from the beginning, and ask if you would like to continue a saved game.
