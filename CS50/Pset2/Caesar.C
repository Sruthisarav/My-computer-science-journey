#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, string argv[])
{
    if (argc == 2)
    {
        // Converts input to integer
        int k = atoi(argv[1]);
        // Gets plaintext from user
        string plain_text = get_string("plaintext: ");
        // Prints ciphertext
        printf("ciphertext: ");
        // Loops through each character in the string
        for (int i=0, length=strlen(plain_text); i<length; i++)
        {
            // Checks if the character is a lowercase letter
            if (plain_text[i]>= 'a' && plain_text[i] <= 'z')
            {
                // Converts the lowercase letter to ciphertext
                char cipher_letter = ((((plain_text[i] - 'a') + k) % 26) + 'a');
                // Prints the ciphertext
                printf("%c", cipher_letter);
            }
            // Checks if the character is an uppercase letter
            else if (plain_text[i]>= 'A' && plain_text[i] <= 'Z')
            {
                // Converts the uppercase letter to ciphertext
                char cipher_letter = ((((plain_text[i] - 'A') + k) % 26) + 'A');
                // Prints the ciphertext
                printf("%c", cipher_letter);
            }
            // Characters that are not letters
            else
            {
                // are unchanged
                printf("%c", plain_text[i]);
            }
        }
    }
    // error message or incorrect input
    else
    {
        printf("Usage: ./caesar key\n");
    } 
    printf("\n");
}
