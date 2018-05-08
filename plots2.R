setwd('/Users/adashaw/Documents/2018spring/cs205_lec/project/Goldbach_Daniel/Goldbach')
###################################SERIAL:10^10####################################################
#speedup plot
rm(list=ls())
png('serial_times_10.png',width = 6, height = 6, units = 'in', res = 300)
executionTime <- c(0.001,0.01,0.23,3.31,41.01,612.71,7264.9)
executionTimeNoFlag <- c(0.004,0.04,0.98,12.56,148.42)
problemSize <- c(5,6,7,8,9,10,11)
problemSize <- 10^problemSize
problemSizeNoFlag <- c(10^5, 10^6, 10^7, 10^8, 10^9)
plot(problemSize,executionTime,type = "p",
     xlab = "Problem size", ylab = "Execution time [s]", main = "Serial execution time versus problem size",
     pch = 17, log='xy', axes=F, col = "blue")
points(problemSizeNoFlag, executionTimeNoFlag, type = 'p', col = "black", pch =15)
axis(1, at = problemSize, labels = NULL)
ey <- -3:4 ; aty <- 10^ey
axis(2, at = aty, labels = NULL)
legend("topleft", legend = c("-O3 flag","No flag"), pch = c(17,15), bty = "n", col = c('blue' ,'black'))
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
ompTime <- c(0.0182789,0.0159928,0.0195439,0.0176216,0.0668218,0.514013,6.25127,75.1181,NA)
parallelTime <- c(2.288,
                  2.271,
                  2.280,
                  2.251,
                  2.277,
                  2.318,
                  2.893,
                  8.328,
                  10.885)
serialTime <- c(.001,
                .001,
                .001,
                .001,
                .007,
                .049,
                1.151,
                13.465,
                19.367)
unoptimizedParallel <- c(2.273,
                         2.039,
                         2.275,
                         2.279,
                         2.306,
                         2.569,
                         4.799,
                         31.697,
                         50.653)
A <- c(2, 3, 4, 5, 6, 7, 8, 9, 10)
problemSize <- c(10^A)
plot(problemSize,serialTime,type = 'p', log ='x', col = "black", pch = 16, 
     ylab = "Execution Time [s]", xlab = "Problem Size", main = "Execution Times versus Problem Size for g3.4xlarge",axes = F, ylim = c(0,80))
points(problemSize, parallelTime,type = 'p', col = "blue", pch =17)
points(problemSize, unoptimizedParallel, type = "p", col ="red", pch =15)
points(problemSize, ompTime, type = "p", col = "green", pch=18)
axis(1, at = problemSize, labels = NULL)
axis(2, at = seq(0,80,by= 10),labels = NULL)
legend("topleft", legend = c("serial","optimized parallel", "parallel","omp"), pch = c(16,17,15,18), bty = "n", col = c('black' ,'blue','red','green'))
dev.off()
##########################################profiling#################################################
rm(list=ls())
png("profiling.png",width = 6, height = 6, units = "in", res = 300)
problemSize <- c(6, 7, 8, 9, 10)
Sieve <- c(25.19,33.59,56.13 ,60.27,60.02)*.01
totalTime <- c(.04,0.54,10.36,140.05,201.47)
Main <- 1 - Sieve
df <- data.frame(problemSize, Sieve, Main)
library(reshape2)
DF1 <- melt(df, id.var="problemSize")
library(ggplot2)
ggplot(DF1, aes(x = problemSize, y = value,fill=variable)) +
  geom_bar(stat='identity')+
  ggtitle(TeX("Function Percentage with $10^n$")) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ylab("%")+xlab("n")+ theme_classic()+theme(legend.title=element_blank())
dev.off()
###################################HYBRID####################################################
#speedup plot
rm(list=ls())
png('hybrid_times_10.png',width = 6, height = 6, units = 'in', res = 300)
executionTime_1e9 <- c(45.401, 28.620, 20.870, 16.623)
executionTime_1e10 <- c(419.131, 218.333, 165.608, 137.703)
executionTime_1e11 <- c(1301.429)
numCores <- c(32, 64, 96, 128)
numCores_1e11 <- c(128)
plot(numCores,executionTime_1e9,type = "p",
     xlab = "Number of cores", ylab = "Execution time [s]", main = "Hybrid MPI-OpenMP execution time vs. number of cores",
     pch = 15, col="black", axes=F, ylim = c(10, 10000), log='y')
points(numCores, executionTime_1e10, type = 'p', col = "blue", pch =16)
points(numCores_1e11, executionTime_1e11, type = 'p', col = "red", pch =17)
axis(1, at = numCores, labels = NULL)
ey <- 1:4 ; aty <- 10^ey
axis(2, at = aty, labels = NULL)
legend("topright", legend=c("Problem size 1e+9","Problem size 1e+10","Problem size 1e+11"), pch = c(15,16,17), bty = "n", col = c('black','blue','red'))
dev.off()
###################################MPI:v1v2####################################################
#speedup plot
rm(list=ls())
png('mpi_v1v2.png',width = 6, height = 6, units = 'in', res = 300)
executionTimeV1 <- c(57.823,45.552,56.347,65.677,99.515,169.731)
executionTimeV2 <- c(49.627,40.191,31.114,30.882,31.508,29.534)
#executionTimeV1 <- c(38.930, 32.608, 36.284, 43.521, 65.745, 158.846)
#executionTimeV2 <- c(30.803, 27.540, 20.933, 20.340, 44.562, 54.105)
numCores <- c(1,2,4,8,16,32)
plot(numCores,executionTimeV1,type = "p",
     xlab = "Number of cores", ylab = "Execution time [s]", main = "MPI execution time versus number of cores: 1.4e+9",
     pch = 15, ylim = c(0,200), axes = F)
points(numCores, executionTimeV2, type = 'p', col = "blue", pch =17)
axis(1, at = numCores, labels = NULL)
axis(2, at = seq(0,200,by=20), labels = NULL)
legend("topleft", legend = c("Version 1: sieve shared via MPI_Send()","Version 2: independent sieve construction"), pch = c(15,17), bty = "n", col = c('black' ,'blue'))
dev.off()
