#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

int shift(char c);
void ciphertext_lower (char c, int key);
void ciphertext_upper (char c, int key);

int main(int argc, string argv[])
{
    if (argc == 2)
    {
        // Assigns the input to keyword
        string keyword = argv[1];
        int k=1;
        for (int i=0, n = strlen(keyword); i<n; i++)
        {
            if (!isalpha(keyword[i]))
            {
                printf("./vigenere keyword \n");
                return 1;
            }
        }
        
        // Gets plaintext from user
        string plain_text = get_string("plaintext: ");
        // Prints ciphertext
        printf("ciphertext: ");
        int counter = 0;
        int key_length = strlen(keyword);
        // Loops through each character in the string
        for (int i=0, length=strlen(plain_text); i<length; i++)
        {
            // Checks if the character is a lowercase letter
            if (plain_text[i]>= 'a' && plain_text[i] <= 'z')
            {
                if (counter == key_length-1)
                {
                    ciphertext_lower(plain_text[i], shift(argv[1][counter]));
                    counter = 0;
                }
                else
                {
                    ciphertext_lower(plain_text[i], shift(argv[1][counter]));
                    counter++;
                }
            }
            // Checks if the character is an uppercase letter
            else if (plain_text[i]>= 'A' && plain_text[i] <= 'Z')
            {
                if (counter == key_length-1)
                {
                    ciphertext_upper(plain_text[i], shift(argv[1][counter]));
                    counter = 0;
                }
                else
                {
                    ciphertext_upper(plain_text[i], shift(argv[1][counter]));
                    counter++;
                }
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
        printf("Usage: ./vigenere keyword\n");
        return 1;
    } 
    printf("\n");
}

int shift(char c)
{
    if (c>= 'a' && c <= 'z')
    {
        return c - 'a';
    }
    else 
    {
        return c - 'A';
    }
}

void ciphertext_lower (char c, int key)
{
    // Converts the lowercase letter to ciphertext
    char cipher_letter = ((((c - 'a') + key) % 26) + 'a');
    // Prints the ciphertext
    printf("%c", cipher_letter);
}

void ciphertext_upper (char c, int key)
{
    // Converts the lowercase letter to ciphertext
    char cipher_letter = ((((c - 'A') + key) % 26) + 'A');
    // Prints the ciphertext
    printf("%c", cipher_letter);
}
