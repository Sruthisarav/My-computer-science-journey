#include <cs50.h>
#include <stdio.h>
#include <math.h>

int main(void) 
{
    float input;
    int n=0;
    do 
    {
        input = get_float("Change Owed: $");
    }
    while(input < 0);
    int cents = round(input * 100);
    while (cents>=0)
    {
        if (cents >= 25)
        {
            cents-=25;
            n++;
        }
        else if (cents >= 10)
        {
           cents-=10;
            n++; 
        }
        else if (cents >= 5)
        {
           cents-=5;
            n++; 
        }
        else if (cents >= 1)
        {
           cents-=1;
            n++; 
        }
        else
        {
            printf("%i\n", n);
            cents--;
        }
    }
}
