// Cracked Passwords using this programme:
// bjbrown:50GApilQSG3E2 -> UPenn

#include <cs50.h>
#include <stdio.h>
#include <crypt.h>
#include <string.h>

int main(int argc, string argv[])
{
    if (argc == 2)
    {
        // Stores input as hash_password
        string hash_password = argv[1];
        // Creates an array called salt
        char salt[3];
        // Finds the salt in the hash password, which is the first two characters
        strncpy(salt, hash_password, 2);
        // Sets the last char in salt array to null
        salt[2] = '\0';
        // list of all the possible characters in the password
        string alphabets = "\0abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        // total number of characters that could possibly appear in the password
        int length_c = 53;
        // guessing first letter of password
        for (int i = 0; i < length_c; i++)
        {
            // guessing second letter of password
            for (int j = 0; j < length_c; j++)
            {
                // guessing third letter of password
                for (int k = 0; k < length_c; k++)
                {
                    // guessing fourth letter of password
                    for (int l = 0; l < length_c; l++)
                    {
                        // guessing fifth letter of password
                        for (int m = 1; m < length_c; m++)
                        {
                            // adds all letters to the array as a possible password
                            char possible_pw[6]= {alphabets[i], alphabets[j], alphabets[k], alphabets[l], alphabets[m], '\0'};
                            // possible password is encrypted
                            string possible_hash = crypt(possible_pw, salt);
                            // checks whether the possible password could be the correct password
                            if (strcmp (possible_hash, hash_password) == 0)
                            {
                                // if true, print out the actual password
                                printf("%s\n", possible_pw);
                                return 0;
                            }
                        }
                    }
                }
            }
        }
        // In the case where password couldn't be cracked
        printf("Could not crack the password\n");
    }
    else 
    {
        // for invalid inputs
        printf("Invalid hash password. \n");
        printf("Usage: ./crack hash \n");
        return 1;
    }
    printf("\n");
}
