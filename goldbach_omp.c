#include <stdio.h>
#include <stdlib.h>
//#include <math.h>
#include "time.h"
#define nt 256
int * sieve(int limit, int* numPrimes){
    unsigned int i,j;
    int *primes;
    int *primesArrayTmp;
    int *primesArray;
    *numPrimes = 0;

    primes = malloc(sizeof(int) * limit);
    primesArrayTmp = malloc(sizeof(int) * limit);

    for (i = 2; i < limit; i++)
        primes[i] = 1;

    for (i = 2; i < limit; i++)
        if (primes[i])
            for (j = i; i * j < limit; j++)
                primes[i * j] = 0;
    
    for (i = 2; i < limit; i++)
        if (primes[i]){
            primesArrayTmp[*numPrimes] = i;
            *numPrimes = *numPrimes + 1;
        }
   
    printf("\nPrime numbers in range 1 to %d are: \n", limit);
    primesArray = malloc(sizeof(int) * *numPrimes);
    for (i = 0; i < *numPrimes; i++){
        primesArray[i] = primesArrayTmp[i];
        printf("%d\n", primesArray[i]);
        }

return primesArray;
}

int isprime(int number) { //returns non zero if number is prime
  int i;
  for ( i = 2; i * i <= number; i++) {
        if (number % i == 0) {
            return 0;
        }
    }
    return 1;
}    

int isvalueinarray(int val, int *arr, int size){
    int i;

    for (i=0; i<=size; i++) {
        if (arr[i] == val)
            return 1;
    }
    return 0;
}

int main(int argc, char** argv) {
    
    int numPrimes;
    int lower, upper, count;    
    lower = atoi(argv[1]);
    upper = atoi(argv[2]);

    clock_t begin = clock();
    
    int * primesArray = sieve(upper, &numPrimes);    
    printf("numPrimes: %d\n", numPrimes); 
    int n;
#pragma omp parallel num_threads(nt)
    {
#pragma omp for
    for ( n = lower; n <= upper; n += 2) {
        count = 0;
	int i;	
for ( i = numPrimes; i >=0; i--) {
            if (isvalueinarray(n - primesArray[i],primesArray,numPrimes)) {
                printf("TRUE %d = %d + %d\n", n, primesArray[i], n - primesArray[i]);
                count = 1;
		break;
	    }
        }
        if (count == 0) {
	    printf("FALSE %d", n);
	}
    }
    }
   
    clock_t end = clock();
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;    
    printf("time spent: %g seconds\n",time_spent);

    return 0;

}          
