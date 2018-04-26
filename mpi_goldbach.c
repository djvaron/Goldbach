#include <stdio.h>
#include <stdlib.h>
#include "time.h"
#include <mpi.h>

int * sieve(int limit){

    unsigned int i,j;
    int *primes;

    primes = malloc(sizeof(int) * limit);
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
    
    int lower, upper, count, i, n, workeri;    
    lower = atoi(argv[1]);
    upper = atoi(argv[2]);
    clock_t begin = clock();
    
    // find primes with sieve
    int * primes = sieve(upper);    

    // do mpi job
    // -----------------------------------------------------
    int rank, size;    
 
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Status status;
     
    
    printf("num processes %d",size);
    if (rank == 0){ // if you are the master thread ...
        // send sieve array to workers
        for (workeri = 1; workeri < size; workeri++){
             MPI_Send(primes, upper, MPI_INTEGER, workeri, 0, MPI_COMM_WORLD);
        }
        // do work
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

    } else { // if you are a worker thread ...
        // receive sieve array from master
        MPI_Recv(primes, upper, MPI_INTEGER, 0, 0, MPI_COMM_WORLD, &status);
        // do work
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
    }
   
    MPI_Finalize();
    
    // -----------------------------------------------------
    
    clock_t end = clock();
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;    
    printf("time spent: %g seconds\n",time_spent);

    free(primes), primes = NULL;

    return 0;

}          
