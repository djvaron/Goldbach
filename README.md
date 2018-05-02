# Numerical verification of the Goldbach conjecture with parallel computing
Authors: Ada Shaw and Daniel Varon

## Introduction
[Goldbach's Conjecture](https://en.wikipedia.org/wiki/Goldbach%27s_conjecture) (1742) proposes that every even number greater than 2 can be written as the sum of two prime numbers. While a formal proof has yet to be discovered, the conjecture has been verified empirically for even numbers up to 4&times;10<sup>18</sup> (Oliveira e Silva et al., 2013).

DESCRIBE HOW PROBLEM IS TYPICALLY SOLVED. HOW DOES IT SCALE, THEORETICALLY?
To verify Goldbach's conjecture for a range of even numbers X = range(xmin,xmax,2), one typically begins by identifying all prime numbers in X. This can be done using a sieve algorithm, e.g. [the Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes).

We designed a simple algorithm in C for verifying Goldbach's conjecture and developed several parallel implementations of the code to identify the best strategies for tackling large problem sizes.

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
