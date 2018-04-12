#speedup plot
setwd('Documents/2018spring/cs205_lec/project')
png('speedup.png',width = 6, height = 6, units = 'in', res = 300)
executionTime <- c(1.666,1.432,0.842,0.519,0.382,0.305,0.284,0.272,0.276)
numThreads <- c(1,2,4,8,16,32,64,128,256)
speedup <- executionTime[1]/executionTime
plot(numThreads,speedup,type = "p",
     xlab = "Number of Threads", ylab = "Speedup", main = "Speedup with Increasing OpenMP Threads",
     pch = 15)
lines(numThreads,speedup)
dev.off()

