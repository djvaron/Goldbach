#include <stdio.h>
#include <stdlib.h>
#include <bits/stdc++.h>
#include "math.h"
using namespace std;

void sieve_of_eratosthenes(int n)
{
    bool prime[n+1];
    memset(prime, true, sizeof(prime));
    int smallest_square;
    smallest_square=floor(pow(n,0.5));
    for (int p=2; p<=smallest_square; p++)
    {
        // If prime[p] is not changed, then it is a prime
        if (prime[p] == true)
        {
            // Update all multiples of p
            for (int i=p*2; i<=n; i += p)
                prime[i] = false;
        }
    }
    
}




int main(int argc, char** argv) {
    
    int lower, upper, count;
    lower = atoi(argv[1]);
    upper = atoi(argv[2]);
    
    for (int n = lower; n <= upper; n += 2) {
        count = 0;
        for (int i = 1; i <= n / 2; i++) {
            if (isprime(i) && isprime(n - i)) {
                printf("TRUE %d = %d + %d\n", n, i, n - i);
                count = 1;
                break;
            }
        }
        if (count == 0) {
            printf("FALSE %d", n);
        }
    }
    return 0;
}
