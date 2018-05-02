# Numerical verification of the Goldbach conjecture with parallel computing
Authors: Ada Shaw and Daniel Varon

## Introduction
Goldbach's Conjecture (1742) proposes that every even number greater than 2 can be written as the sum of two prime numbers. While a formal proof has yet to be discovered, the conjecture has been verified empirically for even numbers up to 4&times;10<sup>18</sup> (Oliveira e Silva et al., 2013).

<img src="https://latex.codecogs.com/svg.latex?\Large&space;x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" title="\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" />


DESCRIBE HOW PROBLEM IS TYPICALLY SOLVED. HOW DOES IT SCALE, THEORETICALLY?

We designed a simple algorithm for verifying Goldbach's conjecture and developed several parallel implementations of the code to identify the best strategies for tackling large problem sizes. The different forms of parallelism tested include:

  * OpenMP shared memory parallelism
  * MPI distributed memory parallelism
  * OpenACC GPU accelerated computing
  * Hybrid MPI-OpenMP parallelism
  * Hybrid ???-OpenACC parallelism

## Serial code
