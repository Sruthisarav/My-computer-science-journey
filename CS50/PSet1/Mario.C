#include <cs50.h>
#include <stdio.h>

// Function that adds hashes
void hash(int i)
{
    while(i>0)
    {
        printf("#");
        i--;
    }   
}

int main(void)
{
    int height;
    do {
        height = get_int("Give me a positive integer between 1 and 20: ");
        printf("Height: %i\n", height);
    }
    while (height<1 || height>20);
    
    for(int i=1; i<=height; i++)
    {
        // Spaces before the hashes
        for(int j=height-i; j>0; j--)
        {
            printf(" ");
        }
        hash(i);
        // the interval between the hashes
        printf("  ");
        hash(i);
        printf("\n");
    }
}
