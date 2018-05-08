#include <stdio.h>
#include <stdlib.h>
#include "time.h"
#include <math.h>
#include "openacc.h"
#include "stdbool.h"

int * sieve(unsigned long long int limit){
    
    unsigned long long int i, j;
    int *primes;

    primes = calloc(limit, sizeof(int));

#pragma acc parallel loop copy(primes[0:limit])
 for (i = 2; i < limit; i++)
        primes[i] = 1;

 int n = floor(pow(limit,0.5));

#pragma acc data copyin(primes[0:limit])
{
#pragma acc region
{
#pragma acc loop independent gang(16), vector(2) 
for (i = 2; i < n; i++)
     // If prime[i] is not changed, then it is a prime
     if (primes[i]) {
         // Update all multiples of i
	  #pragma acc loop independent gang(16), vector(4)
         for ( j = 2*i; j < limit; j += i)
             primes[j] = 0;
     }
}
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
    
//    int lower, upper, count, i, n;    
//    lower = atoi(argv[1]);
//    upper = atoi(argv[2]);
    int count;
    unsigned long long int lower, upper, i, n;
    lower = strtoull(argv[1], (char **)NULL, 10);
    upper = strtoull(argv[2], (char **)NULL, 10);
    printf("lower = %d, upper = %lli \n",lower,upper);

  //  clock_t begin = clock();
    double begin = omp_get_wtime();
    int * primes = sieve(upper);
    int jar = 0;    
#pragma acc parallel copyin(primes[0:upper]) private(jar)
{
#pragma acc loop  
    for (n = lower; n <= upper; n += 2) {
        count = 0;
	for (i = 2; i <= n/2; i++) {
            if (primes[i] && primes[n-i]) {
  //              printf("TRUE %d = %d + %d\n", n, i, n-i);
                count = 1;
		break;
	    }
        }
        if (count == 0) {
//	    printf("FALSE %d", n);
	    jar = 1;
	}
    }
}

   double time_spent = omp_get_wtime() - begin;
//    clock_t end = clock();
//    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;    
    printf("time spent: %g seconds\n",time_spent);
    printf("if jar =  0, goldbach's conjecture stands.\n jar = %d\n",jar);
    free(primes), primes = NULL;

    return 0;

}          
