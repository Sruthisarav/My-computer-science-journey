number=0
i=0
while (i+2 !=len(s)):
    if s[i:i+3]=='bob':
        number+=1
    i+=1
print('Number of times bob occurs is: ' + str(number))
