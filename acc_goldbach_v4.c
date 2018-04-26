#include <stdio.h>
#include <stdlib.h>
#include "time.h"
#include "openacc.h"
#include "math.h"
int * sieve(int limit){
    
    unsigned int i,j;
    int *primes;

    primes = malloc(sizeof(int) * limit);
    #pragma acc kernels
    #pragma acc loop independent
    for (i = 2; i < limit; i++)
        primes[i] = 1;
    
    int val = floor(pow(limit, 0.5));
    
    #pragma acc kernels
    #pragma acc loop independent
    for (i = 2; i < val; i++)
        // If prime[i] is not changed, then it is a prime
        if (primes[i]) {
            // Update all multiples of i
            #pragma acc loop independent
            for ( j = 2*i; j < limit; j += i)
                primes[j] = 0;
        }
    
    /* printf("\nPrime numbers in range 1 to %d are: \n", limit);
    for (i = 2; i < limit; i++){
        if (primes[i])
            printf("%d\n", i);
        }
    */

return primes;
}

int main(int argc, char** argv) {
    
    int lower, upper, count, i, n;    
    lower = atoi(argv[1]);
    upper = atoi(argv[2]);

    clock_t begin = clock();
    
    int * primes = sieve(upper);    
    #pragma acc kernels
    #pragma acc loop independent
    for (n = lower; n <= upper; n += 2) {
        count = 0;
        
	for (i = 2; i <= n/2; i++) {
            if (primes[i] && primes[n-i]) {
                //printf("TRUE %d = %d + %d\n", n, i, n-i);
                count = 1;
		break;
	    }
        }
        if (count == 0) {
	    printf("FALSE %d", n);
	}
    }
   
    clock_t end = clock();
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;    
    printf("time spent: %g seconds\n",time_spent);

    free(primes), primes = NULL;

    return 0;

}          
