#include <stdio.h>
#include <stdlib.h>
#include "time.h"
#include <mpi.h>
#include "stdbool.h"

bool * sieve(long long int limit){

    long long int i,j;
    bool *primes;

    primes = malloc(sizeof(bool) * limit);
    for (i = 2; i < limit; i++)
        primes[i] = 1;

    for (i = 2; i*i < limit; i++)
        if (primes[i]) {
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
    
    int count, workeri;
    long long int lower, upper, i, n;    
    lower = atoi(argv[1]);
    upper = atoi(argv[2]);
    clock_t begin = clock();    

    /* do mpi job 
    ------------------------------------------------------- */
    int rank, size;    
    
    /* initialize the MPI environment */
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Status status;

    /* construct the sieve array */
    bool * primes = sieve(upper);

    /* Print a diagnostic message */
    if (rank == 0)
        printf("Processes: %d\n", size);
    
    /* do the work */
    for (n = lower + 2*rank; n <= upper; n += 2*size) {
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

    MPI_Finalize();
    
    /* ----------------------------------------------------- */
    
    clock_t end = clock();
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;    
    printf("time spent: %g seconds\n",time_spent);

    free(primes), primes = NULL;

    return 0;

}          
