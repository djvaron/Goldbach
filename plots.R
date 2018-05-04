<<<<<<< HEAD
setwd('/Users/adashaw/Documents/2018spring/cs205_lec/project/Goldbach_Daniel/Goldbach')
=======
setwd('/Users/adashaw/Documents/2018spring/cs205_lec/project/Goldbach')
###################################SERIAL:10^10####################################################
#speedup plot
rm(list=ls())
png('serial_times_10.png',width = 6, height = 6, units = 'in', res = 300)
executionTime <- c(63.6211,
                   46.5893,
                   46.6875,
                   43.0204,
                   41.9105,
                   35.9967)
problemSize <- c(1,2,4,8,16,32)
speedup <- executionTime_v0[1]/executionTime_v0
plot(numThreads,speedup,type = "p",
     xlab = "Number of Threads", ylab = "Speedup", main = "Speedup with Increasing OpenMP Threads",
     pch = 15, ylim=c(1,executionTime_v0[1]/tail(executionTime_v0,n=1)))
dev.off()
>>>>>>> 64dd5bf0cc1486fd898ee5a35cd045b51b871e71
###################################OMP:10^10####################################################
#speedup plot
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
     xlab = "Number of Threads", ylab = "Speedup", main = "Speedup with Increasing OpenMP Threads",
     pch = 15, ylim=c(1,executionTime_v0[1]/tail(executionTime_v0,n=1)))
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
                         NA,
                         NA)
A <- c(2, 3, 4, 5, 6, 7, 8, 9, 10, 11)
problemSize <- c(10^A)
plot(problemSize,serialTime,type = 'p', log ='x', col = "black", pch = 16, ylab = "Execution Time [s]", xlab = "Problem Size", axes = F)
points(problemSize,parallelTime,type = 'p', col = "blue", pch =17)
points(problemSize,unoptimizedParallel, type = "p", col ="red", pch =15)
axis(1,at = problemSize, labels = NULL)
axis(2,at = seq(0,100,by= 10),labels = NULL)
legend("topleft", legend = c("serial","optimized parallel", "parallel"), pch = c(16,17,15), bty = "n", col = c('black' ,'blue','red'))
dev.off()