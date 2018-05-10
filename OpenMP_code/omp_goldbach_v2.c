#include <stdio.h>
#include <stdlib.h>
#include "stdbool.h"
#include "omp.h"
#include "math.h"
#include "time.h"

/*bool * sieve(int limit) {
    
    unsigned int i,j;
    bool *primes;

    primes = malloc(sizeof(bool) * limit);
    
    #pragma omp parallel for schedule(static)
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
    
     printf("\nPrime numbers in range 1 to %d are: \n", limit);
    for (i = 2; i < limit; i++){
        if (primes[i])
            printf("%d\n", i);
        }
    

    return primes;
}*/

bool * sieve(unsigned long long int limit){

    unsigned long long int i,j;
    bool *primes;
    
    primes = calloc(limit, sizeof(bool));
    #pragma omp parallel for schedule(static)
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
    
    //int lower, upper, count, i, n;    
    //lower = atoi(argv[1]);
    //upper = atoi(argv[2]);
    int count;
    unsigned long long int lower, upper, i, n;
    lower = strtoull(argv[1], (char **)NULL, 10);
    upper = strtoull(argv[2], (char **)NULL, 10);

    printf("lower = %lli, upper = %lli \n",lower,upper);
    //clock_t begin = clock();
    double begin = omp_get_wtime();

    bool * primes = sieve(upper);    
 
    #pragma omp parallel 
    #pragma omp for ordered   
    for (n = lower; n <= upper; n += 2) {
    #pragma omp ordered
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
//    clock_t end = clock();
//    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;    
    double time_spent = omp_get_wtime() - begin;
    printf("time spent: %g seconds\n",time_spent);

    free(primes), primes = NULL;

    return 0;
}          
