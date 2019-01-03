number=0
i=0
while (i !=len(s)):
    if s[i]=='a':
        number+=1
    elif s[i]=='e':
        number+=1
    elif s[i]=='i':
        number+=1
    elif s[i]=='o':
        number+=1
    elif s[i]=='u':
        number+=1
    i+=1
print('Number of vowels: ' + str(number))
