# Numerical verification of Goldbach's conjecture with parallel computing
__Authors:__ Ada Shaw and Daniel Varon

## Introduction
[Goldbach's Conjecture](https://en.wikipedia.org/wiki/Goldbach%27s_conjecture) (1742) proposes that every even number greater than 2 can be written as the sum of two prime numbers. While a formal proof has yet to be discovered, the conjecture has been verified empirically for even numbers up to 4&times;10<sup>18</sup> (Oliveira e Silva et al., 2013).

To verify Goldbach's conjecture for even numbers in a range X = xmin..xmax, one typically begins by identifying all prime numbers in X. This can be done using a sieve algorithm -- for example, the [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes) -- which produces a Boolean array of length len(X) describing primeness (or not) of integers in X. Then, for each even number x<sub>i</sub> in X, one loops over integers 2 < n < x<sub>i</sub>/2, determining at each iteration whether both n and x<sub>i</sub>-n are prime. If so, the conjecture is satisfied for x<sub>i</sub>.

Two factors limit scalability with increasing integer size:
  1. The average cost of checking primeness grows.
  2. The size of the Boolean sieve array, which occupies len(X) bytes.

We designed a simple algorithm in C for verifying Goldbach's conjecture and developed several parallel implementations of the code to identify the best strategies for tackling large problem sizes, given the above limitations.

We tested the following forms of parallelism:

  * OpenMP shared memory parallelism
  * MPI distributed memory parallelism
  * OpenACC GPU accelerated computing
  * Hybrid MPI-OpenMP parallelism
  * Hybrid ???-OpenACC parallelism

## Serial code
The serial code consists of a main program that verifies Goldbach's conjecture iteratively for even numbers in a user-specified integer range, and a sieve subroutine for finding all the prime numbers in that range.

### Sieve of Eratosthenes

### Main program

## OpenMP

## MPI

## OpenACC

## Hybrid MPI-OpenMP

## Hybrid ???-OpenACC

## Conclusions

## References


## example latex equation:
<img src="https://latex.codecogs.com/svg.latex?\Large&space;x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" title="\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" />
