def isValidWord(word, hand, wordList):
    """
    Returns True if word is in the wordList and is entirely
    composed of letters in the hand. Otherwise, returns False.

    Does not mutate hand or wordList.
   
    word: string
    hand: dictionary (string -> int)
    wordList: list of lowercase strings
    """
    test=0
    for l in word:
        if not l in hand or word.count(l)>hand[l]:
            return False
        elif word.count(l) <= hand[l]:
            test+=1
    if test==len(word) and word in wordList:
        return True
    else:
        return False
