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
        // Finds the salt in the hash password, which is the first two characters
        char salt[3];
        strncpy(salt, hash_password, 2);
        salt[2] = '\0';
        // list of all the possible characters in the password
        string alphabets = "\0abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        // total number of characters that could possibly appear in the password
        int length_c = 53;
        for (int i = 0; i < length_c; i++)
        {
            for (int j = 0; j < length_c; j++)
            {
                for (int k = 0; k < length_c; k++)
                {
                    for (int l = 0; l < length_c; l++)
                    {
                        for (int m = 1; m < length_c; m++)
                        {
                            char possible_pw[6]= {alphabets[i], alphabets[j], alphabets[k], alphabets[l], alphabets[m], '\0'};
                            string possible_hash = crypt(possible_pw, salt);
                            if (strcmp (possible_hash, hash_password) == 0)
                            {
                                printf("%s\n", possible_pw);
                                return 0;
                            }
                        }
                    }
                }
            }
        }
        printf("No password\n");
    }
    else 
    {
        printf("Invalid hash password. \n");
        printf("Usage: ./crack hash \n");
        return 1;
    }
    printf("\n");
}
