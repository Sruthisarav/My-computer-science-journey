#include <cs50.h>
#include <stdio.h>
#include <math.h>

// Function that finds the length of the integer
int length (long input){
  int len=1;
  while (input>9)
  { 
      len++; 
      input/=10; 
  }
  return len;
}

// Function that finds the digit in nth place
int digit(long input, int place)
{
    long divisor = pow(10, place+1);
    long remainder = input % divisor;
    if (remainder>10)
    {
        long divisor_two = pow(10, place);
        int d = remainder / divisor_two;
        return d;
    }
    else
    {
        return remainder;
    }
}

// Function that returns a sum of every other digit multiplied by two
int sum_one(long input, int len)
{
    int sum=0;
    for (int i= len-1; i>0; i-=2)
    {
        sum+= digit(input, len-i) * 2;
    }
    return sum;
}

// Function that returns a sum of leftover digits
int sum_two(long input, int len)
{
    int sum=0;
    for (int i=len; i>0; i-=2)
    {
        sum+=i;
    }
    return sum;
}

int main(void)
{
    long long input;
    do 
    {
        input = get_long("Number: ");
    }
    while (input <= 0);
    int len = length(input);
    int sum1 = sum_one(input, len);
    int sum2 = sum_two(input, len);
    int total_sum = sum1 + sum2;
    if (total_sum % 10)
    {
        switch(len)
        {
            // Checking for American Express Card No.
            case 15:
                if (digit(input, len-1) == 3)
                {
                    if (digit(input, len-2) == 4 || digit(input, len-2) == 7)
                    {
                        printf("AMEX\n");
                    }
                    else
                    {
                        printf("INVALID\n");
                    }
                }
                else
                {
                    printf("INVALID\n");
                }
                break;
            // Checking for Visa Card No.
            case 13:
                if (digit(input, len-1) == 4)
                {
                    printf("VISA\n");
                }
                else
                {
                    printf("INVALID\n");
                }
                break;
            // Checking for Visa or MasterCard Card No.
            case 16:
                if (digit(input, len-1) == 4)
                {
                    printf("VISA\n");
                }
                else if (digit(input, len-1) == 4)
                {
                    if (digit(input, len-2) == 1 || digit(input, len-2) == 2 || digit(input, len-2) == 3 || digit(input, len-2) == 4 || digit(input, len-2) == 5)
                    {
                        printf("MASTERCARD\n");
                    }
                    else {
                        printf("INVALID\n");
                    }
                }
                else 
                {
                    printf("INVALID\n");
                }
                break;
            default:
                printf("INVALID\n");
                break;
        }
    }
    else
    {
        printf("INVALID\n");
    }
}
