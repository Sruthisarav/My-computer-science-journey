def playGame(wordList):
    """
    Allow the user to play an arbitrary number of hands.
 
    1) Asks the user to input 'n' or 'r' or 'e'.
        * If the user inputs 'e', immediately exit the game.
        * If the user inputs anything that's not 'n', 'r', or 'e', keep asking them again.

    2) Asks the user to input a 'u' or a 'c'.
        * If the user inputs anything that's not 'c' or 'u', keep asking them again.

    3) Switch functionality based on the above choices:
        * If the user inputted 'n', play a new (random) hand.
        * Else, if the user inputted 'r', play the last hand again.
      
        * If the user inputted 'u', let the user play the game
          with the selected hand, using playHand.
        * If the user inputted 'c', let the computer play the 
          game with the selected hand, using compPlayHand.

    4) After the computer or user has played the hand, repeat from step 1

    wordList: list (string)
    """
    # TO DO... <-- Remove this comment when you code this function
    n=HAND_SIZE
    gameInput= 'n'
    games=0
    while gameInput != 'e':
        gameInput= str(input('Enter n to deal a new hand, r to replay the last hand, or e to end game: '))
        if gameInput=='n' or gameInput=='r' and games !=0:
            while True:
                userInput=input('Enter u to have yourself play, c to have the computer play: ')
                if userInput=='u':
                    if gameInput=='n':
                        hand= dealHand(n)
                        playHand(hand, wordList, n)
                        games+=1
                        break
                    elif gameInput=='r':
                        playHand(hand, wordList, n)
                        games+=1
                        break
                elif userInput=='c':
                    if gameInput=='n':
                        hand= dealHand(n)
                        compPlayHand(hand, wordList, n)
                        games+=1
                        break
                    elif gameInput=='r':
                        compPlayHand(hand, wordList, n)
                        games+=1
                        break
                else:
                    print('Invalid command.')
        elif gameInput=='e':
            break
        elif gameInput=='r' and games==0:
            print('You have not played a hand yet. Please play a new hand first!')
        else:
            print('Invalid command.')
