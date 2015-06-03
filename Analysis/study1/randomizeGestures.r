directory<-"C:/Users/laura/Desktop/ICMI/Challenge/Gesture Data/test/"
setwd(directory)
fromFile<-read.csv("testset.csv", header=FALSE)
randomized<-fromFile[1,]
fromFile<-fromFile[-1,]

for(gesture in 1:251) {
	yetToGo <- (nrow(fromFile)/432) - 1
	copyFrom <- sample(0:yetToGo, 1)
	fromLine <- (copyFrom*432) + 1
	toLine <- (copyFrom*432) + 432
	print(paste("processing gesture set at line: ", fromLine, " at ", gesture, "/251", sep=""))
	randomized<-rbind(randomized, fromFile[fromLine:toLine,])
	fromFile<-fromFile[-c(fromLine:toLine),]
}

write.table(randomized, "randomizedset.csv", sep=",", row.names=FALSE, col.names=FALSE)