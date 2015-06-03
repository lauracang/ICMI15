setwd("C:/Users/laura/Desktop/ICMI/Touch Data/featureData/")
haart<-read.csv("allFrames1HAART.csv", header=FALSE) #to get the colnames as first row
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


#touch2 <- read.csv("allFrames2WPartChar.csv", header=FALSE)
#dyncurve <- touch2[1,]
#touch2 <- read.csv("allFrames2WPartChar.csv", header=TRUE)
#colnames(dyncurve)<-colnames(touch2)


# nocover<-haart[1,]
# fur<-haart[1,]
# short<-haart[1,]
# long<-haart[1,]

# subflat<-haart[1,]
# subcurve<-haart[1,]
# subfoam<-haart[1,]

# notouch<-haart[1,]
# constant<-haart[1,]
# pat<-haart[1,]
# rub<-haart[1,]
# scratch<-haart[1,]
# stroke<-haart[1,]
# tickle<-haart[1,]
nocoverlist<-0
furlist<-0
shortlist<-0
longlist<-0

flatlist<-0
curvelist<-0
foamlist<-0

notouchlist<-0
constantlist<-0
patlist<-0
rublist<-0
scratchlist<-0
strokelist<-0
ticklelist<-0

haart<-read.csv("allFrames1HAART.csv", header=TRUE) #to get colnames as colnames)
# colnames(nocover)<-colnames(haart)
# colnames(fur)<-colnames(haart)
# colnames(short)<-colnames(haart)
# colnames(long)<-colnames(haart)
# colnames(subflat)<-colnames(haart)
# colnames(subcurve)<-colnames(haart)
# colnames(subfoam)<-colnames(haart)
# colnames(notouch)<-colnames(haart)
# colnames(constant)<-colnames(haart)
# colnames(pat)<-colnames(haart)
# colnames(rub)<-colnames(haart)
# colnames(scratch)<-colnames(haart)
# colnames(stroke)<-colnames(haart)
# colnames(tickle)<-colnames(haart)
coverRows<-haart$cover
substrateRows<-haart$substrate
gestureRows<-haart$type
filelength<-nrow(haart)

for (n in 1:filelength) {
	if (as.vector(coverRows[n]) == "none") {
		print(paste("processing line for cover: ", n, "/", filelength, sep=""))
		nocoverlist<-c(nocoverlist,n)
	} else if (as.vector(coverRows[n]) == "fur") {
		print(paste("processing line for cover: ", n, "/", filelength, sep=""))
		furlist<-c(furlist,n)
	} else if (as.vector(coverRows[n]) == "short") {
		print(paste("processing line for cover: ", n, "/", filelength, sep=""))
		shortlist<-c(shortlist,n)
	} else if (as.vector(coverRows[n]) == "long") {
		print(paste("processing line for cover: ", n, "/", filelength, sep=""))
		longlist<-c(longlist,n)
	}
}



for (n in 1:filelength) {
	if (as.vector(substrateRows[n]) == "none") {
		print(paste("processing line for substrate: ", n, "/", filelength, sep=""))
		flatlist<-c(flatlist,n)
	} else if (as.vector(substrateRows[n]) == "curve") {
		print(paste("processing line for substrate: ", n, "/", filelength, sep=""))
		curvelist<-c(curvelist,n)
	} else if (as.vector(substrateRows[n]) == "foam") {
		print(paste("processing line for substrate: ", n, "/", filelength, sep=""))
		foamlist<-c(curvelist,n)
	}
}

for (n in 1:filelength) {
	if (as.vector(gestureRows[n]) == "notouch") {
		print(paste("processing line for gesture: ", n, "/", filelength, sep=""))
		notouchlist<-c(notouchlist,n)
	} else if (as.vector(gestureRows[n]) == "constant") {
		print(paste("processing line for gesture: ", n, "/", filelength, sep=""))
		constantlist<-c(constantlist,n)
	} else if (as.vector(gestureRows[n]) == "pat") {
		print(paste("processing line for gesture: ", n, "/", filelength, sep=""))
		patlist<-c(patlist,n)
	} else if (as.vector(gestureRows[n]) == "rub") {
		print(paste("processing line for gesture: ", n, "/", filelength, sep=""))
		rublist<-c(rublist,n)
	} else if (as.vector(gestureRows[n]) == "scratch") {
		print(paste("processing line for gesture: ", n, "/", filelength, sep=""))
		scratchlist<-c(scratchlist,n)
	} else if (as.vector(gestureRows[n]) == "stroke") {
		print(paste("processing line for gesture: ", n, "/", filelength, sep=""))
		strokelist<-c(strokelist,n)
	} else if (as.vector(gestureRows[n]) == "tickle") {
		print(paste("processing line for gesture: ", n, "/", filelength, sep=""))
		ticklelist<-c(ticklelist,n)
	}
}

if(nrow(nocover)+nrow(fur)+nrow(short)+nrow(long)==filelength+4){
	setwd("C:/Users/laura/Desktop/ICMI/Touch Data/featureData/furcover1/")
	write.table(haart[], "nocover.csv", sep=",", row.names=FALSE)
	write.table(fur[-1,], "fur.csv", sep=",", row.names=FALSE)
	write.table(short[-1,], "short.csv", sep=",", row.names=FALSE)
	write.table(long[-1,], "long.csv", sep=",", row.names=FALSE)
} else {
	print("Error: not enough rows in cover")
}

if(nrow(subflat)+nrow(subcurve)+nrow(subfoam)==filelength+3){
	setwd("C:/Users/laura/Desktop/ICMI/Touch Data/featureData/substrate1/")
	write.table(subflat[-1,], "subflat.csv", sep=",", row.names=FALSE)
	write.table(subcurve[-1,], "subcurve.csv", sep=",", row.names=FALSE)
	write.table(subfoam[-1,], "subfoam.csv", sep=",", row.names=FALSE)
} else {
	print("Error: not enough rows in substrate")
}
if(nrow(notouch)+nrow(constant)+nrow(pat)+nrow(rub)+nrow(scratch)+nrow(stroke)+nrow(tickle)==filelength+7){
setwd("C:/Users/laura/Desktop/ICMI/Touch Data/featureData/gesture1/")
	write.table(notouch[-1,], "notouch.csv", sep=",", row.names=FALSE)
	write.table(constant[-1,], "constant.csv", sep=",", row.names=FALSE)
	write.table(pat[-1,], "pat.csv", sep=",", row.names=FALSE)
	write.table(rub[-1,], "rub.csv", sep=",", row.names=FALSE)
	write.table(scratch[-1,], "scratch.csv", sep=",", row.names=FALSE)
	write.table(stroke[-1,], "stroke.csv", sep=",", row.names=FALSE)
	write.table(tickle[-1,], "tickle.csv", sep=",", row.names=FALSE)
} else {
	print("Error: not enough rows in gesture")
}
