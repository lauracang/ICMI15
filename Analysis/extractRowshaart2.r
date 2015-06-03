setwd("C:/Users/laura/Desktop/ICMI/Touch Data/allframes/")
haart2<-read.csv("allFrames2WPartChar.csv", header=FALSE, as.is=TRUE) #to get the colnames as first row
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


coverno<-haart2[1,]
coveryes<-haart2[1,]

motionyes<-haart2[1,]
motionno<-haart2[1,]

notouch<-haart2[1,]
constant<-haart2[1,]
pat<-haart2[1,]
rub<-haart2[1,]
scratch<-haart2[1,]
stroke<-haart2[1,]
tickle<-haart2[1,]

haart2<-read.csv("allFrames2WPartChar.csv", header=TRUE, as.is=TRUE) #to get colnames as colnames)
colnames(coverno)<-colnames(haart2)
colnames(coveryes)<-colnames(haart2)
colnames(motionno)<-colnames(haart2)
colnames(motionyes)<-colnames(haart2)
colnames(notouch)<-colnames(haart2)
colnames(constant)<-colnames(haart2)
colnames(pat)<-colnames(haart2)
colnames(rub)<-colnames(haart2)
colnames(scratch)<-colnames(haart2)
colnames(stroke)<-colnames(haart2)
colnames(tickle)<-colnames(haart2)
coverRows<-haart2$cover
stateRows<-haart2$state
gestureRows<-haart2$type
filelength<-nrow(haart2)

for (n in 1:filelength) {
	if (as.vector(coverRows[n]) == "none") {
		print(paste("processing line for cover: ", n, "/", filelength, sep=""))
		coverno<-rbind(coverno, haart2[n,])
	} else if (as.vector(coverRows[n]) == "cover") {
		print(paste("processing line for cover: ", n, "/", filelength, sep=""))
		coveryes<-rbind(coveryes, haart2[n,])
	}
}



for (n in 1:filelength) {
	if (as.vector(stateRows[n]) == "static") {
		print(paste("processing line for state: ", n, "/", filelength, sep=""))
		motionno<-rbind(motionno, haart2[n,])
	} else if (as.vector(stateRows[n]) == "dynamic") {
		print(paste("processing line for state: ", n, "/", filelength, sep=""))
		motionyes<-rbind(motionyes, haart2[n,])
	} 
}


for (n in 1:filelength) {
	if (as.vector(gestureRows[n]) == "notouch") {
		print(paste("processing line for gesture: ", n, "/", filelength, sep=""))
		notouch<-rbind(notouch, haart2[n,])
	} else if (as.vector(gestureRows[n]) == "constant") {
		print(paste("processing line for gesture: ", n, "/", filelength, sep=""))
		constant<-rbind(constant, haart2[n,])
	} else if (as.vector(gestureRows[n]) == "pat") {
		print(paste("processing line for gesture: ", n, "/", filelength, sep=""))
		pat<-rbind(pat, haart2[n,])
	} else if (as.vector(gestureRows[n]) == "rub") {
		print(paste("processing line for gesture: ", n, "/", filelength, sep=""))
		rub<-rbind(rub, haart2[n,])
	} else if (as.vector(gestureRows[n]) == "scratch") {
		print(paste("processing line for gesture: ", n, "/", filelength, sep=""))
		scratch<-rbind(scratch, haart2[n,])
	} else if (as.vector(gestureRows[n]) == "stroke") {
		print(paste("processing line for gesture: ", n, "/", filelength, sep=""))
		stroke<-rbind(stroke, haart2[n,])
	} else if (as.vector(gestureRows[n]) == "tickle") {
		print(paste("processing line for gesture: ", n, "/", filelength, sep=""))
		tickle<-rbind(tickle, haart2[n,])
	}
}

if(nrow(coverno)+nrow(coveryes)==filelength+2){
	setwd("C:/Users/laura/Desktop/ICMI/Touch Data/featureData/cover2/")
	write.table(coverno[-1,], "coverno.csv", sep=",", row.names=FALSE)
	write.table(coveryes[-1,], "coveryes.csv", sep=",", row.names=FALSE)
} else {
	print("Error: not enough rows in cover")
}

if(nrow(motionno)+nrow(motionyes)==filelength+2){
	setwd("C:/Users/laura/Desktop/ICMI/Touch Data/featureData/motion2/")
	write.table(motionno[-1,], "motionno.csv", sep=",", row.names=FALSE)
	write.table(motionyes[-1,], "motionyes.csv", sep=",", row.names=FALSE)
	} else {
	print("Error: not enough rows in motion2")
}

if(nrow(notouch)+nrow(constant)+nrow(pat)+nrow(rub)+nrow(scratch)+nrow(stroke)+nrow(tickle)==filelength+7){
	setwd("C:/Users/laura/Desktop/ICMI/Touch Data/featureData/gesture2/")
	write.table(notouch[-1,], "notouch.csv", sep=",", row.names=FALSE)
	write.table(constant[-1,], "constant.csv", sep=",", row.names=FALSE)
	write.table(pat[-1,], "pat.csv", sep=",", row.names=FALSE)
	write.table(rub[-1,], "rub.csv", sep=",", row.names=FALSE)
	write.table(scratch[-1,], "scratch.csv", sep=",", row.names=FALSE)
	write.table(stroke[-1,], "stroke.csv", sep=",", row.names=FALSE)
	write.table(tickle[-1,], "tickle.csv", sep=",", row.names=FALSE)
} else {
	print("Error: not enough rows in gesture2")
}