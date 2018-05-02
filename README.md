# Numerical verification of the Goldbach conjecture with parallel computing
Goldbach's Conjecture (1742) proposes that every even number greater than 2 can be written as the sum of two prime numbers. While a formal proof has yet to be discovered, the conjecture has been verified empirically for even numbers up to 4e18 (Oliveira e Silva et al., 2013).

We designed a simple algorithm for verifying Goldbach's conjecture and developed several parallel implementations of the code to identify the best strategies for tackling large problem sizes. The different forms of parallelism tested include:

  * OpenMP shared memory parallelism
  * MPI distributed memory parallelism
  * OpenACC GPU accelerated computing
  * Hybrid MPI-OpenMP parallelism
  * Hybrid ???-OpenACC parallelism


