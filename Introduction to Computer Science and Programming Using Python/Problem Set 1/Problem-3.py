alphabet='abcdefghijklmnopqrstuvwxyz'
i=0
j=0
string=''
final=''
while (i<len(s)):
	while(j<len(alphabet)):
		if s[i] == alphabet[j]:
			string+=s[i]
			if i==len(s)-1:
				if len(string)>len(final) and len(string)!=len(final):
					final=string
					string=''
					j=0
					break
				else:
					string=''
					j=0
			break
		elif j==len(alphabet)-1:
			if len(string)>len(final) and len(string)!=len(final):
				final=string
				string=''
				j=0
				i=i-1
				break
			else:
				string=''
				j=0
					
		else:
			j+=1

	i+=1

print("Longest substring in alphabetical order is: "+ final)
