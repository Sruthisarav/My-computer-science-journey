// Implements a dictionary's functionality

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "dictionary.h"

// Represents number of children for each node in a trie
#define N 27

// Represents a node in a trie
typedef struct node
{
    bool is_word;
    struct node *children[N];
}
node;

// Represents a trie
node *root;

// defines unload function
void unload_node(node *pointer);

// Counts the number of words in the dictionary
int word_count = 0;

// Loads dictionary into memory, returning true if successful, else  it returns false
bool load(const char *dictionary)
{
    // Initialize trie
    root = malloc(sizeof(node));
    if (root == NULL)
    {
        return false;
    }
    root->is_word = false;
    for (int i = 0; i < N; i++)
    {
        root->children[i] = NULL;
    }

    // Open dictionary
    FILE *file = fopen(dictionary, "r");
    if (file == NULL)
    {
        unload();
        return false;
    }

    // Buffer for a word
    char word[LENGTH + 1];

    // Insert words into trie
    while (fscanf(file, "%s", word) != EOF)
    {
        node *position = root;
        // find length of word
        int len = strlen(word);
        int index;
        // iterate through each letter in the word excluding '\0'
        for (int i = 0; i < len; i++)
        {
            // for apostrophes assign an index of 26
            if (word[i] == '\'')
            {
                index = 26;
            }
            // for lower case letters:
            else if (word[i] >= 'a' && word[i] <= 'z')
            {
                index = word[i] - 97;
            }
            // for uppercase letters:
            else if (word[i] >= 'A' && word[i] <= 'Z')
            {
                index = word[i] - 65;
            }

            // if the next node is empty
            if (position->children[index] == NULL)
            {
                // allocate space with the size of a node for next node
                position->children[index] = calloc(1, sizeof(node));
            }
            // change position to the next node
            position = position->children[index];
        }

        // there is another word
        position->is_word = true;
        // go back to the very first node
        position = root;
        // add 1 to word count
        word_count++;
    }

    // Close dictionary
    fclose(file);

    // Indicate success
    return true;
}

// Returns number of words in dictionary if loaded else 0 if not yet loaded
unsigned int size(void)
{
    // word count of dictionary
    return word_count;
}

// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    node *position = root;
    // find the length of word
    int len = strlen(word);
    int index;
    for (int k = 0; k < len; k++)
    {
        // for apostrophes, assign an index of 26.
        if (word[k] == '\'')
        {
            index = 26;
        }
        // for lowercase letters
        else if (word[k] >= 'a' && word[k] <= 'z')
        {
            index = word[k] - 97;
        }
        // for uppercase letters
        else if (word[k] >= 'A' && word[k] <= 'Z')
        {
            index = word[k] - 65;
        }

        // if the word cannot be found in the dictionary
        if (!position->children[index])
        {
            return false;
        }

        // changes position to the next letter
        position = position->children[index];
    }
    // if it passes all tests, check if it is a valid word
    return position->is_word;
}

// Unloads dictionary from memory, returning true if successful else false
bool unload(void)
{
    unload_node(root);
    return true;
}

void unload_node(node *pointer)
{   // iterates through every node
    for (int l = 0; l <27; l++)
    {
        // if node is not empty
        if (pointer->children[l] != NULL)
        {
            // unload the rest of the nodes from memory through recursion
            unload_node(pointer->children[l]);
        }
    }
    // frees the node from memory
    free(pointer);
}
