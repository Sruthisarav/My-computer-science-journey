def getGuessedWord(secretWord, lettersGuessed):
	result=[]
	for i in range(len(secretWord)):
		result+="_"
	for i in range(len(secretWord)):
		for j in range(len(lettersGuessed)):
			if secretWord[i] == lettersGuessed[j]:
				result[i]=secretWord[i]
	return(" ".join(result))
