setwd("C:/Users/laura/Desktop/ICMI/Touch Data/featureData/")
#haart<-read.csv("allFrames1HAART.csv", header=FALSE) #to get the colnames as first row
#flat<-haart[1,]
#curved<-haart[1,] #copy colnames to flat
#haart<-read.csv("allFrames1HAART.csv", header=TRUE) #to get colnames as colnames)
#colnames(flat)<-colnames(haart)
#colnames(curved)<-colnames(haart)
#substrateRows<-haart$substrate

#filelength<-length(substrateRows)
# for (n in 1:filelength) {
	# if (as.vector(substrateRows[n]) == "none") {
		# print(paste("processing line: ", n, "/", filelength, sep=""))
		# #flat<-rbind(flat, haart[n,])
		# curved<-rbind(curved, haart[n,])
	# }
# }


touch2 <- read.csv("allFrames2WPartChar.csv", header=FALSE)
dyncurve <- touch2[1,]
touch2 <- read.csv("allFrames2WPartChar.csv", header=TRUE)
colnames(dyncurve)<-colnames(touch2)
stateRows<-touch2$state

filelength<-length(stateRows)

for (n in 1:filelength) {
	if (as.vector(stateRows[n]) == "dynamic") {
		print(paste("processing line: ", n, "/", filelength, sep=""))
		dyncurve<-rbind(dyncurve, touch2[n,])
	}
}

write.table(dyncurve[-1,], "dynamiccurve.csv", sep=",", row.names=FALSE)