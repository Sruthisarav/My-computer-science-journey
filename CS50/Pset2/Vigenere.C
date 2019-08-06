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
    // If there's two words as input
    if (argc == 2)
    {
        // Assigns the input to keyword
        string keyword = argv[1];
        // Check if the given word has only letters and no numbers
        for (int i=0, n = strlen(keyword); i<n; i++)
        {
            // If it's not a letter
            if (!isalpha(keyword[i]))
            {
                // Print error message
                printf("./vigenere keyword \n");
                return 1;
            }
        }
        
        // Gets plaintext from user
        string plain_text = get_string("plaintext: ");
        // Prints ciphertext
        printf("ciphertext: ");
        // Set the intial counter to 0
        int counter = 0;
        // finds the length of the keyword
        int key_length = strlen(keyword);
        // Loops through each character in the string
        for (int i=0, length=strlen(plain_text); i<length; i++)
        {
            // Checks if the character is a lowercase letter
            if (plain_text[i]>= 'a' && plain_text[i] <= 'z')
            {
                // Once the last letter of the keyword has been used, reset counter to 0
                if (counter == key_length-1)
                {
                    // change letter to ciphertext
                    ciphertext_lower(plain_text[i], shift(argv[1][counter]));
                    counter = 0;
                }
                else
                {
                    ciphertext_lower(plain_text[i], shift(argv[1][counter]));
                    // Add 1 to counter so the next letter of keyword is used
                    counter++;
                }
            }
            // Checks if the character is an uppercase letter
            else if (plain_text[i]>= 'A' && plain_text[i] <= 'Z')
            {
                // Once the last letter of the keyword has been used, reset counter to 0
                if (counter == key_length-1)
                {
                    // change letter to ciphertext
                    ciphertext_upper(plain_text[i], shift(argv[1][counter]));
                    counter = 0;
                }
                else
                {
                    ciphertext_upper(plain_text[i], shift(argv[1][counter]));
                    // Add 1 to counter so the next letter of keyword is used
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
        // finds shift value
        return c - 'a';
    }
    else 
    {
        // finds shift value
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
    // Converts the uppercase letter to ciphertext
    char cipher_letter = ((((c - 'A') + key) % 26) + 'A');
    // Prints the ciphertext
    printf("%c", cipher_letter);
}
