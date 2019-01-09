def getAvailableLetters(lettersGuessed):
	availableLetters=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
	for w in lettersGuessed:
		if w in availableLetters:
			availableLetters.remove(w)
	return ''.join(availableLetters)
