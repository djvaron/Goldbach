#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "time.h"

int isprime(int number) { //returns non zero if number is prime
    for (int i = 2; i * i <= number; i++) {
        if (number % i == 0) {
            return 0;
        }
    }
    return 1;
}    

int main(int argc, char** argv) {
    
    int lower, upper, count;    
    lower = atoi(argv[1]);
    upper = atoi(argv[2]);

    clock_t begin = clock();
   
    for (int n = lower; n <= upper; n += 2) {
        count = 0;
	for (int i = 2; i <= n / 2; i++) {
            if (isprime(i) && isprime(n - i)) {
                printf("TRUE %d = %d + %d\n", n, i, n - i);
                count = 1;
		break;
	    }
        }
        if (count == 0) {
	    printf("FALSE %d\n", n);
	}
    }
   
    clock_t end = clock();
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;    
    printf("time spent: %g seconds\n",time_spent);

    return 0;

}          
