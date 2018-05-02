# Numerical verification of Goldbach's conjecture with parallel computing
__Authors:__ Ada Shaw and Daniel Varon

## Introduction
[Goldbach's Conjecture](https://en.wikipedia.org/wiki/Goldbach%27s_conjecture) (1742) proposes that every even number greater than 2 can be written as the sum of two prime numbers. While a formal proof has yet to be discovered, the conjecture has been verified empirically for even numbers up to 4&times;10<sup>18</sup> (Oliveira e Silva et al., 2013).

To verify Goldbach's conjecture for even numbers in the integer interval <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;X&space;=&space;\{x_{\text{min}}&space;\text{&space;}&space;..&space;\text{&space;}&space;x_{\text{max}}\}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;X&space;=&space;\{x_{\text{min}}&space;\text{&space;}&space;..&space;\text{&space;}&space;x_{\text{max}}\}" title="X = \{x_{\text{min}} \text{ } .. \text{ } x_{\text{max}}\}" /></a>, one typically begins by identifying all prime numbers in <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;X" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;X" title="X" /></a>. This can be done using a sieve algorithm (e.g., the [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)), which produces a Boolean array of length <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;L&space;=&space;x_{\text{max}}-x_{\text{min}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;L&space;=&space;x_{\text{max}}-x_{\text{min}}" title="L = x_{\text{max}}-x_{\text{min}}" /></a> describing primeness (or not) of integers in <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;X" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;X" title="X" /></a>. Then, for a given even number <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x" title="x" /></a> in <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;X" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;X" title="X" /></a>, one loops over integers <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;2&space;\leq&space;n&space;\leq&space;x/2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;2&space;\leq&space;n&space;\leq&space;x/2" title="2 \leq n \leq x/2" /></a>, determining for each <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;n" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;n" title="n" /></a> whether both <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;n" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;n" title="n" /></a> and <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x-n" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x-n" title="x-n" /></a> are prime. If so, the conjecture is satisfied for <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x" title="x" /></a>.

Two factors limit scalability of this approach with increasing integer size:
  1. The average cost of checking primeness grows.
  2. The size <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;L" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;L" title="L" /></a> of the Boolean sieve array grows, demanding <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;L" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;L" title="L" /></a> bytes in memory.

We designed a simple algorithm in C for verifying Goldbach's conjecture and developed several parallel implementations of the code to identify the best strategies for tackling the problem with increasing integer size.

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


## example latex equation with HTML, from [codecogs](https://www.codecogs.com/latex/eqneditor.php):
<img src="https://latex.codecogs.com/svg.latex?\Large&space;x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" title="\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" />
