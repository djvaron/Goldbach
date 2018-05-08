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
  * Hybrid MPI-OpenMP parallelism
  * OpenACC GPU accelerated computing

## 2. System specifications
Experiments with the serial code, MPI, OpenMP, and hybrid MPI/OpenMP were conducted on the `huce_intel` partition of the Harvard Odyssey research computing cluster. Experiments with OpenACC were conducted on AWS using a `g3.4xlarge` instance with 16 GB of GPU memory.  

`huce_intel` specs:
```Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                32
On-line CPU(s) list:   0-31
Thread(s) per core:    1
Core(s) per socket:    16
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 79
Stepping:              1
CPU MHz:               2095.331
BogoMIPS:              4189.99
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              40960K
NUMA node0 CPU(s):     0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30
NUMA node1 CPU(s):     1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31
```

`g3.4xlarge` specs:
```
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                16
On-line CPU(s) list:   0-15
Thread(s) per core:    2
Core(s) per socket:    8
Socket(s):             1
NUMA node(s):          1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 79
Model name:            Intel(R) Xeon(R) CPU E5-2686 v4 @ 2.30GHz
Stepping:              1
CPU MHz:               2698.906
CPU max MHz:           3000.0000
CPU min MHz:           1200.0000
BogoMIPS:              4600.13
Hypervisor vendor:     Xen
Virtualization type:   full
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              46080K
NUMA node0 CPU(s):     0-15
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single retpoline kaiser fsgsbase bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx xsaveopt
```

Odyssey software:
  * GCC version: `4.4.7`
  * mpich version: `3.2`
  * intel version: `17.0.2`
  * Linux version: `2.6.32-642.6.2.el6.centos.plus.x86_64`
  * CUDA driver version: `9010`
  * pgcc version: `17.10-0 64-bit`

## 3. Serial code
The serial code `goldbach.c` consists of:
  1. an Eratosthenes sieve subroutine for finding all the prime numbers in an input integer interval, and 
  2. a loop for verifying Goldbach's conjecture for even numbers in the input interval.

Example of vanilla compile &amp; run commands: 
  * compile: `gcc goldbach.c -o goldbach`
  * run: `./goldbach <x_min> <x_max>`.

### 3.1. Eratosthenes sieve

This subroutine initializes a Boolean array of size `limit` = <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x_{\text{max}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x_{\text{max}}" title="x_{\text{max}}" /></a> bytes in heap memory, with all elements set to 1. It then loops over integers <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;i" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" /></a> from 2 to `floor(sqrt(limit))`, setting the array value for all (non-unit) multiples of <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;i" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" /></a> to 0. The result is a Boolean array of size <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x_{\text{max}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x_{\text{max}}" title="x_{\text{max}}" /></a> with non-zero elements at the positions of prime numbers.

```C
#include <stdio.h>
#include <stdlib.h>
#include "time.h"
#include "stdbool.h"

bool * sieve(unsigned long long int limit){

    unsigned long long int i,j;
    bool *primes;
    
    /* initialize primes array of 1's */
    primes = malloc(sizeof(bool) * limit);
    for (i = 2; i < limit; i++)
        primes[i] = 1;

    /* update all multiples of i */
    for (i = 2; i*i < limit; i++)
        if (primes[i]) {
            for (j = 2*i; j < limit; j += i)
                primes[j] = 0;
        }

return primes;
}
```

### 3.2. Verification loop
This routine checks Goldbach's conjecture for all even numbers in an input integer interval specified by `lower` and `upper` bounds. It first calls the sieve subroutine to identify all prime numbers from 1 to the `upper` bound. Next, it loops over even numbers in the interval, determining by comparison with the sieve array whether they satisfy the conjecture.

```C
int main(int argc, char** argv) {

    int count;
    unsigned long long int lower, upper, i, n;
    lower = strtoull(argv[1], (char **)NULL, 10);
    upper = strtoull(argv[2], (char **)NULL, 10);

    clock_t begin = clock();
    
    /* construct sieve array */
    bool * primes = sieve(upper);

    /* check conjecture for even integers in input integer range */
    for (n = lower; n <= upper; n += 2) {
        count = 0;
        for (i = 2; i <= n/2; i++) {
            if (primes[i] && primes[n-i]) {
                /* for trouble-shooting: */
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
### 3.3. Performance analysis

We find that the computational cost of verifying Goldbach's conjecture using our simple implementations of the Eratosthenes sieve and verification loop is trivial up to 10<sup>7</sup>. From there, the cost grows rapidly. Using the `O3` optimization flag speeds up our code by nearly a factor of four for problem sizes 10<sup>8</sup> and higher. We therefore use `O3` optimization for all of our parallel implementations.

<img src="https://github.com/ardwwa/Goldbach/blob/master/serial_times_10.png" width="600" alt="SERIAL"/>

Problem size for our serial code is limited to 10<sup>11</sup> by the underlying architecture of the `huce_intel` partition, which consists of 32-core nodes with 4 GB RAM per core, for a total of 128 GB RAM per node. For `limit` = 10<sup>11</sup>, the sieve array <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;B" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;B" title="B" /></a> occupies 100 GB, saturating random access memory on an individual node.

There are at least two possible approaches to overcoming this memory limitation:
  1. Store the sieve array across multiple nodes and communicate the different parts via MPI.
  2. Store the sieve in disk space.

Neither of these approaches is ideal, however, because passing large arrays between nodes is costly (see Sect. 5), as is loading them from disk space. We leave direct testing of these two options to a future work, limiting our analysis here to the interval {1 .. 10<sup>11</sup>}.

To better understand how cost scales with problem size, we profiled our code using the GNU gprof profiler and plotted the fractions of execution time spent on the Eratosthenes sieve and verification loop versus problem size:

<img src="https://github.com/ardwwa/Goldbach/blob/master/profiling.png" width="600" alt="OPENACC"/>

For problem sizes greater than 10<sup>7</sup>, our code spends more time in the sieve subroutine than the verification loop. Thus, we expect that parallelizing the sieve should produce the greatest performance gains when the problem size is large. 

## 4. OpenMP
We implemented OpenMP and parallelized our code across 1 to 32 threads on [type of intel CPU] and generated the figure below.  
<img src="https://github.com/ardwwa/Goldbach/blob/master/omp_speedup_10.png" width="600" alt="OPENMP"/>

## 5. MPI
We explored two MPI implementations of our code. 

#### Approach 1
In the first approach, the master process constructs the Eratosthenes sieve array before sharing it with worker processes via `MPI_Send()`. The verification loop iterations are then distributed among workers. It is important to distribute the work equally, because otherwise execution time is limited by the slowest process. Block partitioning of the input integer interval into sequential sub-intervals is not a viable way to distribute labor, since large numbers (with many possible prime components) take longer to process than small numbers. Instead, we assign integers to each worker process cyclically. For example, if there are 4 workers processing the integer interval {4 .. 20}, work is assigned as follows:
  * worker 0 processes [4, 12, 20]. 
  * worker 1 processes [6, 14].
  * worker 2 processes [8, 16].
  * worker 3 processes [10, 18].

This approach has two major weaknesses: 
  1. First, it does not parallelize the Eratosthenes sieve, which accounts for most of the execution time for large problem sizes. 
  2. Second, it requires that large arrays (up to 10-100 GB) be passed via `MPI_Send()`, which is costly.

#### Approach 2
In the second MPI approach, each process constructs its own sieve array before work is distributed as in approach 1. This MPI implementation also fails to parallelize the Eratosthenes sieve, but it boosts performance by distributing the verification loop iterations to numerous workers without incurring `MPI_Send()` overhead costs.

#### Comparison
We compare execution times of the two MPI approaches for a problem size of 1.4&times;10<sup>10</sup>, using up to 32 cores on a single node:

<img src="https://github.com/ardwwa/Goldbach/blob/master/mpi_v1v2.png" width="600" alt="OPENACC">

Performance in approach 1 diminishes as the number of cores increases. This is because the sieve array, which occupies 1.4 GB, must be passed from the master process to an increasing number of worker processes. By contrast, performance in approach 2 improves with increasing core count up to `numCores = 4`, but then remains nearly constant. This is because the cost of initializing and maintaining the MPI environment offsets performance gains from increased parallelism of the verification loop. Adding more cores will only increase performance if the problem size is increased as well and/or the sieve array is assembled in distributed memory.

We see that our decision to forego multi-node assembly and storage of the Eratosthenes sieve array in this work (see Sect. 3.3) imposes a key limitation on the performance gains that distributed memory parallelism can provide. We know that parallelizing the sieve subroutine is desirable because, as shown in Sect. 3.3, it accounts for most of the execution time for large problem sizes. However, at this stage in our project, the best we can do is to apply shared memory parallelism to the Eratosthenes sieve, and distributed memory parallelism to the verification loop. We describe such a hybrid parallel approach in Sect. 6.

Example compile &amp; run commands:
```C
$ module load intel/17.0.2-fasrc01 mpich/3.2-fasrc03
$ mpicc -O3 v1_mpi_goldbach.c -o v1_mpi_O3
$ time mpirun -np 8 ./v1_mpi_O3 4 1000000000
```

## 6. Hybrid MPI-OpenMP
We designed a hybrid MPI-OpenMP version of our code that parallelizes the Eratosthenes sieve in shared memory and the verification loop in distributed memory. We request multiple `huce_intel` nodes and on each of them direct up to 32 processors to construct the prime number sieve array. The verification loop iterations are then distributed equally across all nodes, using the cyclical work assignment strategy described in Sect. 5. We test performance using up to 128 processors across 4 full compute nodes.

We compare execution times for different problem sizes and numbers of processors:

<img src="https://github.com/ardwwa/Goldbach/blob/master/hybrid_times_10.png" width="600" alt="HYBRID">

This approach scales better than the OpenMP and MPI approaches discussed in Sect. 4 and 5. With 128 processors across 4 compute nodes we are able to verify Goldbach's conjecture for even numbers up to 10<sup>11</sup> in a reasonable amount of time (approximately 20 minutes).

Example compile &amp; run commands:
```C
$ module load intel/17.0.2-fasrc01 mpich/3.2-fasrc03
$ mpicc -O3 -fopenmp hybrid_goldbach.c -o hybrid_O3 -lm
$ export OMP_NUM_THREADS=32
$ time srun -n 4 --cpus-per-task=32 --mpi=pmi2 ./hybrid_O3 4 10000000000
```

## 7. OpenACC
<img src="https://github.com/ardwwa/Goldbach/blob/master/acc_speedup.png" width="600" alt="OPENACC">

  The increase in execution time scales strangely with problem size, with a slow increase that accelerates after 10<sup>8</sup>. The ACC optimization becomes beneficial only after 10^8. This is because the communications overhead with transfering the primes boolean array between the threads hinders the performance of the parallel code, however once the serial code is slowed down by the 10<sup>8</sup> problem size, the communications overhead becomes small compared to the performance boost of the parallel code.

  The optimized parallel code uses gangs and vectors to parallelize the code among more threads. The unoptimized parallel code uses the default 128 thread count which access the same global memory of the primes array. We desire more threads due to the embarrasingly parallel nature of our code, however without blocking, the memory access to the primes array is hindered by communications overhead. So instead of pulling from global memory again, blocking the primes array into the shared memory allows other threads within the same block to access and edit it. Specifying number of gangs distributes the primes array into a number of blocks to be shared by a smaller number of threads, decreasing the communications overhead when editing the primes array. The maximum number of threads in the system is 2048 (pgaccelinfo), so the total number of threads executing per block must multiply to 2048. We optimize the distribution of work into the blocks and threads and see a substantial increase in performance as seen by the blue triangles (gang/vector distributed work) versus red squares (unoptimized). 
  
  We are unsure why the OpenACC acceleration is better than the OpenMP. We postulate that OpenACC is more optimized than OpenACC with GPU architecture. Additionally, the blocking as seen by the unoptimized versus optimized OpenACC improves the OpenACC performance by reducing the communications overheads to the primes array.
  
  At 10<sup>10</sup>, the code experiences a segmentation fault. This is because the size of the boolean primes array becomes on the order of 10 GB and the CUDA global memory size for the g3.4xlarge was 8 GB. To test a number larger than 10<sup>10</sup>, a multi-node code with MPI-OpenACC across more than one GPU could be developed.

## 8. Conclusions

  * OpenACC is our fastest implementation for problem size 10<sup>11</sup> (???).
  * Problem size is limited by the size of the Eratosthenes sieve array.
  * If we want to solve larger problems, we need to find a new way to store the sieve array, because it quickly grows too large to be stored in RAM on a single `huce_intel` compute node. We have at least two options, neither of which is ideal:
    1. store sieve array in disk space (I/O bottleneck).
    2. store sieve array across several (added costs from MPI communication of array segments).
  * If we want to speed up our code for larger problem sizes, we need to increase parallelism of the Eratosthenes sieve. That means developing an MPI implementation that constructs the sieve across several nodes. This fits will with option 2 above. 
  * Probably the best possible approach is to use a massive MPI algorithm that uses a large number of nodes to construct the sieve array in parallel and then distribute the verification loop iterations to many workers. It's unclear whether the best implementation would be MPI-only, hybrid MPI-OpenMP, or hybrid MPI-OpenACC, since we don't know how the problem scales when the sieve array is distributed across several nodes. 

## References
  * Oliveria e Silva, T., Herzog, S., and Pardi, S.: Empirical verification of the even Goldbach conjecture and computation of prime gaps up to 4&times;10<sup>18</sup>. _Math. Comput._, 83(288), 2033-2060, [https://doi.org/10.1090/S0025-5718-2013-02787-1](https://doi.org/10.1090/S0025-5718-2013-02787-1), 2014.

## example latex equation with HTML, from [codecogs](https://www.codecogs.com/latex/eqneditor.php):
<img src="https://latex.codecogs.com/svg.latex?\Large&space;x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" title="\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" />

[This stackoverflow page](https://stackoverflow.com/questions/11256433/how-to-show-math-equations-in-general-githubs-markdownnot-githubs-blog?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa) was also useful for understanding math equations in markdown.

Also, [this page](http://vim.wikia.com/wiki/Moving_around) about moving around in vim.

Also also, [this markdown cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#code).




