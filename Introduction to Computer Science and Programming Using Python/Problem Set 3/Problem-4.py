import random

WORDLIST_FILENAME = "words.txt"

def loadWords():
    """
    Returns a list of valid words. Words are strings of lowercase letters.
    
    Depending on the size of the word list, this function may
    take a while to finish.
    """
    print("Loading word list from file...")
    # inFile: file
    inFile = open(WORDLIST_FILENAME, 'r')
    # line: string
    line = inFile.readline()
    # wordlist: list of strings
    wordlist = line.split()
    print("  ", len(wordlist), "words loaded.")
    return wordlist

def chooseWord(wordlist):
    """
    wordlist (list): list of words (strings)

    Returns a word from wordlist at random
    """
    return random.choice(wordlist)

# end of helper code
# -----------------------------------

# Load the list of words into the variable wordlist
# so that it can be accessed from anywhere in the program
wordlist = loadWords()

def isWordGuessed(secretWord, lettersGuessed):
    '''
    secretWord: string, the word the user is guessing
    lettersGuessed: list, what letters have been guessed so far
    returns: boolean, True if all the letters of secretWord are in lettersGuessed;
      False otherwise
    '''
    # FILL IN YOUR CODE HERE...
    correctGuesses=0
    for w in secretWord:
        if w in lettersGuessed:
            correctGuesses+=1
    if correctGuesses == len(secretWord):
        return True
    else: 
        return False


def getGuessedWord(secretWord, lettersGuessed):
    '''
    secretWord: string, the word the user is guessing
    lettersGuessed: list, what letters have been guessed so far
    returns: string, comprised of letters and underscores that represents
      what letters in secretWord have been guessed so far.
    '''
    # FILL IN YOUR CODE HERE...
    result=[]
    for i in range(len(secretWord)):
        result+="_"
    for i in range(len(secretWord)):
        for j in range(len(lettersGuessed)):
            if secretWord[i] == lettersGuessed[j]:
                result[i]=secretWord[i]
    return(" ".join(result))


def getAvailableLetters(lettersGuessed):
    '''
    lettersGuessed: list, what letters have been guessed so far
    returns: string, comprised of letters that represents what letters have not
      yet been guessed.
    '''
    # FILL IN YOUR CODE HERE...
    availableLetters=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
    for w in lettersGuessed:
        if w in availableLetters:
            availableLetters.remove(w)
    return ''.join(availableLetters)    

def hangman(secretWord):
    '''
    secretWord: string, the secret word to guess.

    Starts up an interactive game of Hangman.

    * At the start of the game, let the user know how many 
      letters the secretWord contains.

    * Ask the user to supply one guess (i.e. letter) per round.

    * The user should receive feedback immediately after each guess 
      about whether their guess appears in the computers word.

    * After each round, you should also display to the user the 
      partially guessed word so far, as well as letters that the 
      user has not yet guessed.

    Follows the other limitations detailed in the problem write-up.
    '''
    # FILL IN YOUR CODE HERE...

    print("Welcome to the game, Hangman!")
    print("I am thinking of a word that is",str(len(secretWord)),"letters long.")
    def guessing(secretWord):
        numberGuesses=8
        lettersGuessed=[]
        guess=''
        while numberGuesses>0 and isWordGuessed(secretWord, lettersGuessed)!= True:
            print("-------------")
            print("You have "+ str(numberGuesses)+ " guesses left.")
            print("Available letters: "+str(getAvailableLetters(lettersGuessed)))
            guess=input("Please guess a letter: ")
            for i in range(len(secretWord)):
                if guess==secretWord[i]:
                    if guess in lettersGuessed:
                        print("Oops! You've already guessed that letter: "+ getGuessedWord(secretWord, lettersGuessed))
                        break
                    else: 
                        lettersGuessed.append(guess)
                        print("Good guess: "+ getGuessedWord(secretWord, lettersGuessed))
                        break
                elif i==len(secretWord)-1:
                    if guess in lettersGuessed:
                        print("Oops! You've already guessed that letter: "+ getGuessedWord(secretWord, lettersGuessed))
                        break
                    else: 
                        lettersGuessed.append(guess)
                        numberGuesses-=1
                        print("Oops! That letter is not in my word: "+ getGuessedWord(secretWord, lettersGuessed))
                        break
                    
        if isWordGuessed(secretWord, lettersGuessed) == True:
            print("-------------")
            print("Congratulations, you won!")
        elif isWordGuessed(secretWord, lettersGuessed) == False:
            print("-------------")
            print("Sorry, you ran out of guesses. The word was "+secretWord+".")

    guessing(secretWord)



# When you've completed your hangman function, uncomment these two lines
# and run this file to test! (hint: you might want to pick your own
# secretWord while you're testing)

secretWord = chooseWord(wordlist).lower()
hangman(secretWord)
