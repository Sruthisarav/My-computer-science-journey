def isWordGuessed(secretWord, lettersGuessed):
	correctGuesses=0
	for w in secretWord:
		if w in lettersGuessed:
			correctGuesses+=1
	if correctGuesses == len(secretWord):
		return True
	else: 
		return False
