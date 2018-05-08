#include <stdio.h>
#include <stdlib.h>
#include "time.h"
#include "stdbool.h"
#include "omp.h"
#include "math.h"
bool * sieve(long long int limit){
    
    unsigned int i,j;
    bool *primes;


    primes = calloc(limit, sizeof(bool));
#pragma omp parallel for 
    for (i = 2; i < limit; i++)
        primes[i] = 1;
    int val = floor(pow(limit,0.5));
#pragma omp parallel for schedule(dynamic)
    for (i = 2; i < val; i++)
        // If prime[i] is not changed, then it is a prime
        if (primes[i]) {
            // Update all multiples of i
#pragma omp parallel for 
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
    
    //int lower, count;
    //long long int upper, i, n;     
    //lower = atoi(argv[1]);
    //upper = atoi(argv[2]);

    int count;
    unsigned long long int lower, upper, i, n;
    lower = strtoull(argv[1], (char **)NULL, 10);
    upper = strtoull(argv[2], (char **)NULL, 10);

    printf("lower = %lli, upper = %lli \n",lower,upper);
//    clock_t begin = clock();
    double begin= omp_get_wtime();
    bool * primes = sieve(upper);    
//    printf("size of B[0]: %d \n", sizeof(primes[0]));    
//    printf("bits for long long integer: %d\n", 8*sizeof(long long int));
 #pragma omp parallel for schedule(dynamic)
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
	    printf("FALSE %lli", n);
	}
    }
  
   // clock_t end = clock();
    double time_spent = omp_get_wtime() - begin;
//    printf("checked: %lli \n", n);
    printf("time spent: %.5g seconds\n", time_spent);

    free(primes);

    return 0;

}          
