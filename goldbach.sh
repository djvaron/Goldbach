#!/bin/bash
#SBATCH -n 32                    # Number of cores
#SBATCH -N 1                    # Ensure that all cores are on one machine
#SBATCH -t 0-01:00              # Runtime in D-HH:MM
#SBATCH -p huce_intel           # Partition to submit to
#SBATCH --mem=64000            # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o threads_32_%j.out           # File to which STDOUT will be written
#SBATCH -e threads_32_%j.err           # File to which STDERR will be written
#SBATCH --mail-type=END         # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=ayshaw@g.harvard.edu      # Email to which notifications will be sent

export OMP_NUM_THREADS=32
export OMP_STACKSIZE="512M"

./omp_goldbach 4 1000000000
