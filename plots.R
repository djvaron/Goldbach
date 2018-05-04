setwd('/Users/adashaw/Documents/2018spring/cs205_lec/project/Goldbach_Daniel/Goldbach')
###################################HYBRID_10####################################################
#speedup plot
rm(list=ls())
png('hybrid_times_10.png',width = 6, height = 6, units = 'in', res = 300)
executionTime <- c(57.209, 32.274, 22.692, 19.632)
numCores <- c(32, 64, 96, 128)
plot(numCores,executionTime,type = "p",
     xlab = "Number of cores", ylab = "Execution time [s]", main = "Hybrid MPI-OpenMP execution time versus number of cores: 1e+10",
     pch = 15, ylim = c(0,200), axes = F)
axis(1, at = numCores, labels = NULL)
axis(2, at = seq(0,60,by=10), labels = NULL)
dev.off()
###################################MPI:v1v2####################################################
#speedup plot
rm(list=ls())
png('mpi_v1v2.png',width = 6, height = 6, units = 'in', res = 300)
executionTimeV1 <- c(57.823,45.552,56.347,65.677,99.515,169.731)
executionTimeV2 <- c(49.627,40.191,31.114,30.882,30.508,29.534)
numCores <- c(1,2,4,8,16,32)
plot(numCores,executionTimeV1,type = "p",
     xlab = "Number of cores", ylab = "Execution time [s]", main = "MPI execution time versus number of cores: 1e+10",
     pch = 15, ylim = c(0,200), axes = F)
points(numCores, executionTimeV2, type = 'p', col = "blue", pch =17)
axis(1, at = numCores, labels = NULL)
axis(2, at = seq(0,200,by=20), labels = NULL)
legend("topleft", legend = c("Version 1: sieve shared via MPI_Send","Version 2: independent sieve construction"), pch = c(15,17), bty = "n", col = c('black' ,'blue'))
dev.off()
###################################SERIAL:10^10####################################################
#execution times
rm(list=ls())
png('serial_times_10.png',width = 6, height = 6, units = 'in', res = 300)
executionTime <- c(0,0.01,0.23,3.31,41.01,59.63)
executionTimeNoFlag <- c(0,0.04,0.98,12.56,148.42,214.81)
problemSize <- c(5,6,7,8,9,10)
problemSize <- 10^problemSize
plot(problemSize,executionTimeNoFlag,type = "p",
     xlab = "Problem size", ylab = "Execution time [s]", main = "Serial execution time versus problem size",
     pch = 15, log='x', axes = F)
points(problemSize, executionTime, type = 'p', col = "blue", pch =17)
axis(1, at = problemSize, labels = NULL)
axis(2, at = seq(0,240,by=40), labels = NULL)
legend("topleft", legend = c("No flag","-O3 flag"), pch = c(15,17), bty = "n", col = c('black' ,'blue'))
dev.off()
###################################OMP:10^10####################################################
#speedup plot
library(latex2exp)
rm(list=ls())
png('omp_speedup_10.png',width = 6, height = 6, units = 'in', res = 300)
executionTime_v0 <- c(63.6211,
                      46.5893,
                      46.6875,
                      43.0204,
                      41.9105,
                      35.9967)
numThreads <- c(1,2,4,8,16,32)
speedup <- executionTime_v0[1]/executionTime_v0
plot(numThreads,speedup,type = "p",
     xlab = "Number of Threads", ylab = "Speedup",main = TeX("Problem Size $10^{10}$"),
     pch = 15,axes = F, ylim = c(1,2))
axis(1,at = numThreads, labels = NULL)
axis(2,at = seq(1,2,by= .25),labels = NULL)
dev.off()
#####################################OMP:10^9####################################################
png('omp_speedup_9.png',width = 6, height = 6, units = 'in', res = 300)
executionTime_v0 <- c(43.8269,
                      36.3054,
                      29.0519,
                      29.9225,
                      29.3303,
                      24.7641)
numThreads <- c(1,2,4,8,16,32)
speedup <- executionTime_v0[1]/executionTime_v0
plot(numThreads,speedup,type = "p",
     xlab = "Number of Threads", ylab = "Speedup", main = "Speedup with Increasing OpenMP Threads",
     pch = 15, ylim=c(1,executionTime_v0[1]/tail(executionTime_v0,n=1)))
dev.off()
#####################################OMP:10^8####################################################
png('omp_speedup_8.png',width = 6, height = 6, units = 'in', res = 300)
executionTime_v0 <- c(13.1992,
                      11.7,
                      8.03956,
                      6.96384,
                      6.55461,
                      2.29872)
numThreads <- c(1,2,4,8,16,32)
speedup <- executionTime_v0[1]/executionTime_v0
plot(numThreads,speedup,type = "p",
     xlab = "Number of Threads", ylab = "Speedup", main = "Speedup with Increasing OpenMP Threads",
     pch = 15, ylim=c(1,executionTime_v0[1]/tail(executionTime_v0,n=1)))
dev.off()
#################################ACC:PROBLEM SIZE VARIABLE########################################
png('acc_speedup.png', width = 6, height = 6, units = "in", res = 300)
parallelTime <- c(2.12186,
                  2.05815,
                  2.05366,
                  2.01458,
                  2.06065,
                  2.13231,
                  2.83341,
                  9.38933,
                  12.3877,
                  11.1563)
serialTime <- c(4.20E-05,
                4.40E-05,
                0.000152,
                0.001917,
                0.023018,
                0.256998,
                3.79028,
                42.7085,
                61.3641,
                NA)
unoptimizedParallel <- c(2.03827,
                         1.95644,
                         1.88567,
                         2.05259,
                         2.04441,
                         2.33071,
                         4.79394,
                         33.8034,
                         53.9939,
                         NA)
A <- c(2, 3, 4, 5, 6, 7, 8, 9, 10, 11)
problemSize <- c(10^A)
plot(problemSize,serialTime,type = 'p', log ='x', col = "black", pch = 16, 
     ylab = "Execution Time [s]", xlab = "Problem Size", main = "Execution Times versus Problem Size",axes = F, ylim = c(0,100))
points(problemSize,parallelTime,type = 'p', col = "blue", pch =17)
points(problemSize,unoptimizedParallel, type = "p", col ="red", pch =15)
axis(1,at = problemSize, labels = NULL)
axis(2,at = seq(0,100,by= 10),labels = NULL)
legend("topleft", legend = c("serial","optimized parallel", "parallel"), pch = c(16,17,15), bty = "n", col = c('black' ,'blue','red'))
dev.off()
