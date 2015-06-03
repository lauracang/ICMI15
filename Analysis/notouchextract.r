setwd("C:/Users/laura/Desktop/ICMI/Touch Data/notouch12/")
notouchdata<-read.csv("notouch.csv", header=FALSE, as.is=TRUE) #to get the colnames as first row
#flat<-haart2[1,]
#curved<-haart2[1,] #copy colnames to flat
#haart<-read.csv("allFrames1HAART.csv", header=TRUE) #to get colnames as colnames)
#colnames(flat)<-colnames(haart2)
#colnames(curved)<-colnames(haart2)
#substrateRows<-haart$substrate

#filelength<-length(substrateRows)
# for (n in 1:filelength) {
	# if (as.vector(substrateRows[n]) == "none") {
		# print(paste("processing line: ", n, "/", filelength, sep=""))
		# #flat<-rbind(flat, haart2[n,])
		# curved<-rbind(curved, haart2[n,])
	# }
# }


#touch2 <- read.csv("allFrames2WPartChar.csv", header=FALSE)
#dyncurve <- touch2[1,]
#touch2 <- read.csv("allFrames2WPartChar.csv", header=TRUE)
#colnames(dyncurve)<-colnames(touch2)


mcnono<-notouchdata[1,]
mcnoyes<-notouchdata[1,]

mcyesno<-notouchdata[1,]
mcyesyes<-notouchdata[1,]


notouchdata<-read.csv("notouch.csv", header=TRUE, as.is=TRUE) #to get colnames as colnames)
colnames(mcnono)<-colnames(notouchdata)
colnames(mcnoyes)<-colnames(notouchdata)
colnames(mcyesno)<-colnames(notouchdata)
colnames(mcyesyes)<-colnames(notouchdata)
motionRows<-notouchdata$state
coverRows<-notouchdata$covered

filelength<-nrow(notouchdata)

for (n in 1:filelength) {
	if (motionRows[n] == "static" && coverRows[n] == "none") {
		print(paste("processing line for cover: ", n, "/", filelength, sep=""))
		mcnono<-rbind(mcnono, notouchdata[n,])
	} else if (motionRows[n] == "static" && coverRows[n] == "cover") {
		print(paste("processing line for cover: ", n, "/", filelength, sep=""))
		mcnoyes<-rbind(mcnoyes, notouchdata[n,])
	} else if (motionRows[n] == "dynamic" && coverRows[n] == "none") {
		print(paste("processing line for cover: ", n, "/", filelength, sep=""))
		mcyesno<-rbind(mcyesno, notouchdata[n,])
	} else if (motionRows[n] == "dynamic" && coverRows[n] == "cover") {
		print(paste("processing line for cover: ", n, "/", filelength, sep=""))
		mcyesyes<-rbind(mcyesyes, notouchdata[n,])
	}
}



if(nrow(mcnono)+nrow(mcnoyes)+nrow(mcyesno)+nrow(mcyesyes)==filelength+4){
	setwd("C:/Users/laura/Desktop/ICMI/Touch Data/featureData/motion/")
	write.table(mcnono[-1,], "mcnono.csv", sep=",", row.names=FALSE)
	write.table(mcnoyes[-1,], "mcnoyes.csv", sep=",", row.names=FALSE)
	write.table(mcyesno[-1,], "mcyesno.csv", sep=",", row.names=FALSE)
	write.table(mcyesyes[-1,], "mcyesyes.csv", sep=",", row.names=FALSE)
} else {
	print("Error: not enough rows in cover")
}

