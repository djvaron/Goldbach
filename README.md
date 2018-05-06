# Numerical verification of Goldbach's conjecture with parallel computing
__Authors:__ Ada Shaw and Daniel Varon

## 1. Introduction
[Goldbach's Conjecture](https://en.wikipedia.org/wiki/Goldbach%27s_conjecture) (1742) proposes that every even number greater than 2 can be written as the sum of two prime numbers. While a formal proof has yet to be discovered, the conjecture has been verified empirically for even numbers up to 4&times;10<sup>18</sup> (Oliveira e Silva et al., 2014).

To verify Goldbach's conjecture for even numbers in the integer interval <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;X&space;=&space;\{x_{\text{min}}&space;\text{&space;}&space;..&space;\text{&space;}&space;x_{\text{max}}\}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;X&space;=&space;\{x_{\text{min}}&space;\text{&space;}&space;..&space;\text{&space;}&space;x_{\text{max}}\}" title="X = \{x_{\text{min}} \text{ } .. \text{ } x_{\text{max}}\}" /></a>, one typically begins by identifying all prime numbers up to <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x_{\text{max}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x_{\text{max}}" title="x_{\text{max}}" /></a>. This can be done using a sieve algorithm (e.g., the [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)), which produces a Boolean array <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;B" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;B" title="B" /></a> of length <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x_{\text{max}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x_{\text{max}}" title="x_{\text{max}}" /></a> describing the primeness (or not) of integers in the interval <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\{1&space;\text{&space;}&space;..&space;\text{&space;}&space;x_{\text{max}}\}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;\{1&space;\text{&space;}&space;..&space;\text{&space;}&space;x_{\text{max}}\}" title="\{1 \text{ } .. \text{ } x_{\text{max}}\}" /></a>. Then, for a given even number <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x&space;\in&space;X" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x&space;\in&space;X" title="x \in X" /></a>, one loops over integers <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;2&space;\leq&space;n&space;\leq&space;x/2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;2&space;\leq&space;n&space;\leq&space;x/2" title="2 \leq n \leq x/2" /></a>, determining for each <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;n" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;n" title="n" /></a> whether both <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;n" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;n" title="n" /></a> and <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x-n" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x-n" title="x-n" /></a> are prime. If so, the conjecture is satisfied for <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x" title="x" /></a>.

Assuming a fixed value of <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x_{\text{min}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x_{\text{min}}" title="x_{\text{min}}" /></a>, two factors limit the scalability of this approach with increasing integer size <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x_{\text{max}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x_{\text{max}}" title="x_{\text{max}}" /></a>:
  1. The average cost of checking primeness grows.
  2. The size of the sieve array <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;B" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;B" title="B" /></a> grows, demanding <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;L" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;L" title="L" /></a> bytes in memory.

We designed a simple algorithm in C for verifying Goldbach's conjecture and developed several parallel implementations of the code to identify the best strategies for tackling the problem as integer size increases.

We tested the following forms of parallelism:

  * OpenMP shared memory parallelism
  * MPI distributed memory parallelism
  * OpenACC GPU accelerated computing
  * Hybrid MPI-OpenMP parallelism
  * Hybrid ???-OpenACC parallelism

## 2. System specifications
Experiments with MPI, OpenMP and the MPI/OpenMP hybrid were carried out on the huce_intel Harvard Odyssey research computing cluster. Experiments with OpenACC were carried out on an AWS  g3.4xlarge with 16 GiB of GPU memory.  

## 3. Serial code
The serial code `goldbach.c` consists of:
  1. an Eratosthenes sieve subroutine for finding all the prime numbers in an input integer interval, and 
  2. a main program for verifying Goldbach's conjecture for even numbers in the input interval.

Example of vanilla compile &amp; run commands: 
  * compile: `gcc goldbach.c -o goldbach`
  * run: `./goldbach <x_min> <x_max>`.

### 3.1. Eratosthenes sieve

This subroutine initializes a Boolean array of 1's in heap memory with size `limit` = <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x_{\text{max}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x_{\text{max}}" title="x_{\text{max}}" /></a> bytes. It then loops over integers <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;i" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" /></a> from 2 to `floor(sqrt(limit))`, setting the array value for all (non-unit) multiples of <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;i" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" /></a> to 0. The result is a Boolean array of size <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x_{\text{max}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x_{\text{max}}" title="x_{\text{max}}" /></a> with non-zero elements indicating that the numbers at those array positions are prime.

```C
#include <stdio.h>
#include <stdlib.h>
#include "time.h"
#include "stdbool.h"

bool * sieve(int limit){

    unsigned int i,j;
    bool *primes;
    
    /* initialize primes array of 1's */
    primes = malloc(sizeof(bool) * limit);
    for (i = 2; i < limit; i++)
        primes[i] = 1;

    /* update all multiples of i */
    for (i = 2; i*i < limit; i++)
        if (primes[i]) {
            for ( j = 2*i; j < limit; j += i)
                primes[j] = 0;
        }

return primes;
}
```

### 3.2. Main program
This routine checks Goldbach's conjecture for all even numbers in an input integer interval specified by `lower` and `upper` bounds. It first calls the sieve subroutine to identify all prime numbers from 2 to the `upper` bound. Next, it loops over even numbers in the interval, determining by comparison with the sieve array whether they satisfy the conjecture. There is the option to print the result for each number, though we do so only while trouble-shooting.

```C
int main(int argc, char** argv) {

    int lower, upper, count, i, n;
    lower = atoi(argv[1]);
    upper = atoi(argv[2]);

    clock_t begin = clock();
    
    /* construct sieve array */
    bool * primes = sieve(upper);

    /* check conjecture for even integers in input integer range */
    for (n = lower; n <= upper; n += 2) {
        count = 0;
        for (i = 2; i <= n/2; i++) {
            if (primes[i] && primes[n-i]) {
                /* printf("TRUE %d = %d + %d\n", n, i, n-i); */
                count = 1;
                break;
            }
        }
        /* print statement if conjecture is not satisfied */
        if (count == 0) {
            printf("FALSE %d", n);
        }
    }

    clock_t end = clock();
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("time spent: %g seconds\n",time_spent);
   
    /* erase sieve array */
    free(primes), primes = NULL;

    return 0;
}
```
### 3.3. Performance optimization

<img src="https://github.com/ardwwa/Goldbach/blob/master/serial_times_10.png" width="600" alt="serial times 10"/>

<img src="https://github.com/ardwwa/Goldbach/blob/master/profiling.png" width="600" alt="OPENACC"/>
Running a GNU gprof profiler on the serial code, we found that for a problem size greater than 10^7, our code spends more time in the sieve function than the main for loop that checks through the primes array. Therefore focusing our acceleration in the sieve is the most important for a problem size greater than 10^7. 

## 4. OpenMP
We implemented OpenMP and parallelized our code across 1 to 32 threads on [type of intel CPU] and generated the figure below.  
<img src="https://github.com/ardwwa/Goldbach/blob/master/omp_speedup_10.png" width="600" alt="OPENMP"/>


## 5. MPI
<img src="https://github.com/ardwwa/Goldbach/blob/master/mpi_v1v2.png" width="600" alt="OPENACC">


## 6. OpenACC
<img src="https://github.com/ardwwa/Goldbach/blob/master/acc_speedup.png" width="600" alt="OPENACC">

  The increase in execution time scales strangely with problem size, with a slow increase that accelerates after 10^8. We think that [insert reasoning why]. The ACC optimization becomes beneficial only after 10^8. This is because the communications overhead with transfering the primes boolean array between the threads hinders the performance of the parallel code, however once the serial code is slowed down by the 10^8 problem size, the communications overhead becomes small compared to the performance boost of the parallel code.

  The optimized parallel code uses gangs and vectors to parallelize the code among more threads. The unoptimized parallel code uses the default 128 thread count which access the same shared memory of the primes array. We desire more threads due to the embarrasingly parallel nature of our code, however without blocking, the memory access to the primes array is hindered by communications overhead. Specifying number of gangs distributes the primes array into a number of blocks to be shared by a smaller number of threads, decreasing the communications overhead when editing the primes array. The maximum number of threads in the system is 2048 (pgaccelinfo), so the total number of threads executing per block must multiply to 2048. We optimize the distribution of work into the blocks and threads and see a substantial increase in performance as seen by the blue triangles (gang/vector distributed work) versus red squares (unoptimized). 
  
  At 10^11, the code experiences a segmentation fault. This is because the size of the boolean primes array becomes on the order of 100 GiB and the maximum storage for the g3.4xlarge array I requested was 8GiB which I modified to 16GiB by requesting more memory. To test a number larger than 10^11, a multi-node code with MPI-ACC across more than one GPU could be developed.

## 7. Hybrid MPI-OpenMP
<img src="https://github.com/ardwwa/Goldbach/blob/master/hybrid_times_10.png" width="600" alt="OPENACC">

## 8. Hybrid ???-OpenACC

## 9. Conclusions

## References
  * Oliveria e Silva, T., Herzog, S., and Pardi, S.: Empirical verification of the even Goldbach conjecture and computation of prime gaps up to 4&times;10<sup>18</sup>. _Math. Comput._, 83(288), 2033-2060, [https://doi.org/10.1090/S0025-5718-2013-02787-1](https://doi.org/10.1090/S0025-5718-2013-02787-1), 2014.

## example latex equation with HTML, from [codecogs](https://www.codecogs.com/latex/eqneditor.php):
<img src="https://latex.codecogs.com/svg.latex?\Large&space;x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" title="\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" />

[This stackoverflow page](https://stackoverflow.com/questions/11256433/how-to-show-math-equations-in-general-githubs-markdownnot-githubs-blog?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa) was also useful for understanding math equations in markdown.

Also, [this page](http://vim.wikia.com/wiki/Moving_around) about moving around in vim.

Also also, [this markdown cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#code).




