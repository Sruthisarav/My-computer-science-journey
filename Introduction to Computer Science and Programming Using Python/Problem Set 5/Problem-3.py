class CiphertextMessage(Message):
    def __init__(self, text):
        '''
        Initializes a CiphertextMessage object
                
        text (string): the message's text

        a CiphertextMessage object has two attributes:
            self.message_text (string, determined by input text)
            self.valid_words (list, determined using helper function load_words)
        '''
        Message.__init__(self, text)

    def decrypt_message(self):
        '''
        Decrypt self.message_text by trying every possible shift value
        and find the "best" one. We will define "best" as the shift that
        creates the maximum number of real words when we use apply_shift(shift)
        on the message text. If s is the original shift value used to encrypt
        the message, then we would expect 26 - s to be the best shift value 
        for decrypting it.

        Note: if multiple shifts are  equally good such that they all create 
        the maximum number of you may choose any of those shifts (and their
        corresponding decrypted messages) to return

        Returns: a tuple of the best shift value used to decrypt the message
        and the decrypted message text using that shift value
        '''
        decodededMessage=''
        encryptedMessage=''
        bestShift=0
        num=0
        for int in range(26):
            value=0
            encryptedMessage=self.apply_shift(int)
            list=encryptedMessage.split()
            for word in list:
                if word in self.valid_words:
                    value+=1
            if value>num:
                bestShift=int
                decodededMessage=encryptedMessage
                num=value
        return (bestShift, decodededMessage)