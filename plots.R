setwd('/Users/adashaw/Documents/2018spring/cs205_lec/project/Goldbach_Daniel/Goldbach')
# ###################################SERIAL:10^10####################################################
# #speedup plot
# rm(list=ls())
# png('serial_times_10.png',width = 6, height = 6, units = 'in', res = 300)
# executionTime <- c(0,0.01,0.23,3.31,41.01,59.63)
# executionTimeNoFlag <- c(0,0.04,0.98,12.56,148.42,214.81)
# problemSize <- c(5,6,7,8,9,10)
# problemSize <- 10^problemSize
# plot(problemSize,executionTimeNoFlag,type = "p",
#      xlab = "Problem size", ylab = "Execution time [s]", main = "Serial execution time versus problem size",
#      pch = 15, log='x')
# points(problemSize, executionTime, type = 'p', col = "blue", pch =17)
# legend("topleft", legend = c("No flag","-O3 flag"), pch = c(15,17), bty = "n", col = c('black' ,'blue'))
# dev.off()
# ###################################OMP:10^10####################################################
#speedup plot
library(latex2exp)
rm(list=ls())
png('omp_speedup_10.png',width = 6, height = 6, units = 'in', res = 300)
speedup_10 <- 69.0098/c(497.25,
                      408.993,
                      351.904,
                      358.511,
                      344.347,
                      296.157)
speedup_9 <-43.8269/c(43.8269,
                      36.3054,
                      29.0519,
                      29.9225,
                      29.3303,
                      24.7641)
speedup_8 <- 13.1992/c(13.1992,
                      11.7,
                      8.03956,
                      6.96384,
                      6.55461,
                      2.29872)
numThreads <- c(1,2,4,8,16,32)

plot(numThreads,speedup_10,type = "p",
     xlab = "Number of Threads", ylab = "Speedup",main = TeX("OpenMP Speedup"),
     pch = 15,axes = F, ylim = c(1,7),col = 'blue')
points(numThreads,speedup_9,pch = 16,col = 'black')
points(numThreads,speedup_8,pch = 17,col='red')
legend("topleft",legend = c(TeX('$10^{10}$'),TeX('$10^{9}$'),TeX('$10^{8}$')),
       pch = c(15,16,17),bty='n',col = c('blue','black','red'))

axis(1,at = numThreads, labels = NULL)
axis(2,at = seq(1,7,by= 1),labels = NULL)
dev.off()


#####################################OMP:10^9####################################################
# png('omp_speedup_9.png',width = 6, height = 6, units = 'in', res = 300)
# executionTime_v0 <- c(43.8269,
#                       36.3054,
#                       29.0519,
#                       29.9225,
#                       29.3303,
#                       24.7641)
# numThreads <- c(1,2,4,8,16,32)
# speedup <- executionTime_v0[1]/executionTime_v0
# plot(numThreads,speedup,type = "p",
#      xlab = "Number of Threads", ylab = "Speedup", main = "Speedup with Increasing OpenMP Threads",
#      pch = 15, ylim=c(1,executionTime_v0[1]/tail(executionTime_v0,n=1)))
# dev.off()
# #####################################OMP:10^8####################################################
# png('omp_speedup_8.png',width = 6, height = 6, units = 'in', res = 300)
# executionTime_v0 <- c(13.1992,
#                       11.7,
#                       8.03956,
#                       6.96384,
#                       6.55461,
#                       2.29872)
# numThreads <- c(1,2,4,8,16,32)
# speedup <- executionTime_v0[1]/executionTime_v0
# plot(numThreads,speedup,type = "p",
#      xlab = "Number of Threads", ylab = "Speedup", main = "Speedup with Increasing OpenMP Threads",
#      pch = 15, ylim=c(1,executionTime_v0[1]/tail(executionTime_v0,n=1)))
# dev.off()
#################################ACC:PROBLEM SIZE VARIABLE########################################
rm(list = ls())
png('acc_speedup.png', width = 6, height = 6, units = "in", res = 300)
#ompTime <- c(0.0182789,0.0159928,0.0195439,0.0176216,0.0668218,0.514013,6.25127,75.1181)
parallelTime <- c(2.288, 2.271,2.280,2.251, 2.277, 2.318, 2.893,8.328)
serialTime <- c(.001,.001,.001,.001,.007,.049,1.151, 13.465)
unoptimizedParallel <- c(2.273,
                         2.039,
                         2.275,
                         2.279,
                         2.306,
                         2.569,
                         4.799,
                         31.697)
A <- c(2, 3, 4, 5, 6, 7, 8, 9)
problemSize <- c(10^A)
plot(problemSize,serialTime/parallelTime,type = 'p', log ='x', col = "black", pch = 6, 
     ylab = "Speedup", xlab = "Problem Size", main = "Speedup versus Problem Size for g3.4xlarge",
     axes = F, ylim = c(0,3))
#points(problemSize, parallelTime,type = 'p', col = "blue", pch =17)
points(problemSize, serialTime/unoptimizedParallel, type = "p", col ="red", pch =4)
#points(problemSize, ompTime, type = "p", col = "green", pch=18)
axis(1, at = problemSize, labels = NULL)
axis(2, at = seq(0,3,by= .5),labels = NULL)
legend("topleft", legend = c("optimized parallel", "parallel"), pch = c(6,4), bty = "n", col = c('black','red'))
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
#################################blocking optimization############################################
rm(list=ls())
png("blocking_optimization_9.png", width = 6, height = 6, units = "in", res= 300)
code <- c("default\nblocksize", "block\noptimized",'serial')
times<- c(31.697,8.328,13.465)
barplot(times,main = "OpenACC Execution Time", xlab ="",names.arg = code,col = 'blue',ylim =c(0,35))
dev.off()
################################overall speedup###################################################
rm(list=ls())
png("overall_speedup.png",width = 6, height = 6, units = "in", res= 300)
aws_serial <- c(.001,.001,.001,.001,.007,.049,1.151, 13.465,NA,NA)
aws_acc <- c(2.288, 2.271,2.280,2.251, 2.277, 2.318, 2.893,8.328,NA,NA)
acc_speedup = aws_serial/aws_acc
ody_serial<- c(0.003,0.003,0.004,0.007,0.020,0.210,3.063,36.293,424.16,NA)
ody_speedup <- ody_serial/c(NA,NA,0.0824091, 0.0812076,0.089224, 0.283266,2.29872,24.7641 ,296.157,NA)
hybrid_speedup = ody_serial/c(NA,NA,NA,NA,NA,NA,NA,16.623,137.703,1301.429)
#MPI_speedup = c(NA,NA,NA,NA,NA,NA,NA,NA,)
problemSize <- c(2, 3, 4, 5, 6, 7, 8, 9, 10,11)
plot(problemSize,acc_speedup,xlab='n',ylab="speedup",main=TeX("Parallel Speedup of Various Architectures at $10^n$")
     , pch = 17,col='blue',ylim = c(0,5),axes = F)
points(problemSize, ody_speedup,pch = 16, col = 'black')
points(problemSize,hybrid_speedup,pch=18,col = 'green')
axis(1, at = problemSize, labels = NULL)
axis(2, at = seq(0,5,by= 1),labels = NULL)
legend("topleft", legend = c('OpenACC', 'OpenMP','OpenMP-MPI'),col=c('blue', 'black','green'), 
       pch = c(17,16,18),bty='n')
dev.off()