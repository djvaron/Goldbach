# Numerical verification of Goldbach's conjecture with parallel computing
__Authors:__ Ada Shaw and Daniel Varon

## 1. Introduction
[Goldbach's Conjecture](https://en.wikipedia.org/wiki/Goldbach%27s_conjecture) (1742) proposes that every even number greater than 2 can be written as the sum of two prime numbers. While a formal proof has yet to be discovered, the conjecture has been verified empirically for even numbers up to 4&times;10<sup>18</sup> (Oliveira e Silva et al., 2014).

To verify Goldbach's conjecture for even numbers in the integer interval <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;X&space;=&space;\{x_{\text{min}}&space;\text{&space;}&space;..&space;\text{&space;}&space;x_{\text{max}}\}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;X&space;=&space;\{x_{\text{min}}&space;\text{&space;}&space;..&space;\text{&space;}&space;x_{\text{max}}\}" title="X = \{x_{\text{min}} \text{ } .. \text{ } x_{\text{max}}\}" /></a>, one typically begins by identifying all prime numbers in <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;X" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;X" title="X" /></a>. This can be done using a sieve algorithm (e.g., the [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)), which produces a Boolean array <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;B" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;B" title="B" /></a> of length <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;L&space;=&space;x_{\text{max}}-x_{\text{min}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;L&space;=&space;x_{\text{max}}-x_{\text{min}}" title="L = x_{\text{max}}-x_{\text{min}}" /></a> describing the primeness (or not) of integers in <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;X" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;X" title="X" /></a>. Then, for a given even number <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x&space;\in&space;X" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x&space;\in&space;X" title="x \in X" /></a>, one loops over integers <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;2&space;\leq&space;n&space;\leq&space;x/2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;2&space;\leq&space;n&space;\leq&space;x/2" title="2 \leq n \leq x/2" /></a>, determining for each <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;n" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;n" title="n" /></a> whether both <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;n" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;n" title="n" /></a> and <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x-n" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x-n" title="x-n" /></a> are prime. If so, the conjecture is satisfied for <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x" title="x" /></a>.

Two factors limit scalability of this approach with increasing integer size <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x_{\text{max}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;x_{\text{max}}" title="x_{\text{max}}" /></a>:
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

## 3. Serial code
The serial code `goldbach.c` consists of:
  1. an Eratosthenes sieve subroutine for finding all the prime numbers in an input integer interval, and 
  2. a main program for verifying Goldbach's conjecture for even numbers in the input interval.

Example of vanilla compile &amp; run commands: 
  * compile: `gcc goldbach.c -o goldbach`
  * run: `./goldbach <x_min> <x_max>`.

### 3.1. Eratosthenes sieve
```C
int we can put code here with syntax highlighting.
```

### 3.2. Main program
```C
int such code, very smart, wow;
```

## 4. OpenMP

## 5. MPI

## 6. OpenACC

## 7. Hybrid MPI-OpenMP

## 8. Hybrid ???-OpenACC

## 9. Conclusions

## References
  * Oliveria e Silva, T., Herzog, S., and Pardi, S.: Empirical verification of the even Goldbach conjecture and computation of prime gaps up to 4&times;10<sup>18</sup>. _Math. Comput._, 83(288), 2033-2060, [https://doi.org/10.1090/S0025-5718-2013-02787-1](https://doi.org/10.1090/S0025-5718-2013-02787-1), 2014.

## example latex equation with HTML, from [codecogs](https://www.codecogs.com/latex/eqneditor.php):
<img src="https://latex.codecogs.com/svg.latex?\Large&space;x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" title="\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" />

[This stackoverflow page](https://stackoverflow.com/questions/11256433/how-to-show-math-equations-in-general-githubs-markdownnot-githubs-blog?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa) was also useful for understanding math equations in markdown.

Also, [this page](http://vim.wikia.com/wiki/Moving_around) about moving around in vim.

Also also, [this markdown cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#code).




