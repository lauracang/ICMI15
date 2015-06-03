between1and10<-function(x) {
	return(x>=0 && x<=10)
}

centrow<-function(x) {
	rowcent <- 0
	totalval <- sum(x)
	if (totalval != 0) {
		for (i in 1:10) {
			for (j in 1:10) {
				tmpval<-j*x[i,j]
				rowcent<-sum(rowcent, tmpval)
			}
		}
		return(rowcent/totalval)
	}
	else
		return(rowcent)
	
	
}

centcol<-function(x) {
	colcent<-0
	totalval<-sum(x)
	if (totalval != 0) {
		for (i in 1:10) {
			for(j in 1:10) {
				tmpval<-i*x[i,j]
				colcent<-sum(colcent,tmpval)
			}
		}
		return(colcent/totalval)
	}
	else	
		return(colcent)
}


totalvar<-function(x) {
	tmptv<-0
	for (i in 1:(length(x)-1)) {	
		tmp<-abs(x[i] - x[i+1])
		tmptv<-tmptv+tmp
	}
	return(tmptv)
}

auc<-function(x) {
	return(sum(x))
}

findtuple<-function(x, type) {
	foundmax<-max(x)
	foundmin<-min(x)
	foundmean<-mean(x)
	foundmedian<-median(x)
	foundvariance<-var(x)
	foundtotvar<-totalvar(x)
	foundauc<-auc(x)
	tuple<-c(foundmax, foundmin, foundmean, foundmedian, foundvariance, foundtotvar, foundauc, type)
	return(tuple)
}


coverID<-c("fur", "long", "none", "short")
substrateID<-c("curve", "foam", "none")
gestureID <- c("constant", "notouch", "pat", "rub", "scratch", "stroke", "tickle")
user<- c("140729-4", "140729-8", "140729-7", "140729-5", "140729-10", "140729-3", "140729-6", "140729-1", "140729-2", "140729-9")

startDir <- "C:/Users/laura/Desktop/ICMI/Challenge/Gesture Data/test/"
framesumDir <- "C:/Users/laura/Desktop/ICMI/Challenge/Gesture Data/test/all frames/"
for(z in 1:10){
	userID<-user[z]

	currFolder<-paste(startDir, userID, sep="")
	setwd(currFolder)
	#setwd(currFolder)
	for(y in 1:3) { 			#substrate
		substrateType <- substrateID[y]
		#for (x in 1:4) {		#cover
		for (x in 1:4){
			coverType <- coverID[x]
			#for (w in 1:7) {	#gesture
			for (w in 1:7) {
				gestureType <- gestureID[w]
				if (z == 4 && y == 2 && x == 3) {}  #note: 5 is missing foam-none condition
				else if (z == 5 && y == 1 && x == 1 && w == 1) {} #note: 10 missing curve fur constant
				else if (z == 6 && y == 2 && x == 3 && w == 4) {} #note: 3 is missing foam none rub
				else if (z == 7 && y == 2 && x == 3 && w == 4) {} #note: 6 is missing foam none rub
				else if (z == 9 && y == 3 && x == 1 && w == 1) {} #note: 2 is missing none fur constant
				else {
					if (z == 8) { 	#note: 1 is named without .csv
						currFile <- paste(userID, substrateType, coverType, gestureType, sep = "")
					} else {
						currFile<-paste(userID, substrateType, coverType, gestureType, ".csv", sep="")
					}			
			
					
					currTemp <- read.csv(currFile, header=FALSE) 
					print(paste("Processing file: ", currFile, sep=""))
					#use header=FALSE if using original file; use header=TRUE if using amended file
					#currTemp <- read.csv(currFile, header = TRUE) 	
					
					
					currTemp <- 1023 - currTemp		#invert data to be 0 - 1023 rather than 1023 - 0
					# write.csv(currTemp, file=paste(dataDir, user, coverType, stateType, gestureType, ".csv", sep= ""), row.names=FALSE)
					#currTemp <- currTemp[,2:9]		#take middle 8 columns
					
					#Temp8x8 <- c(1,2,3,4,5,6,7,8,9,10) 	#set first row to define col size (to be deleted later)
					
					#for (i in 1:5400) {				#take middle 8 rows per frame
					#	if (i%%10 == 1 || i%%10 == 0) {
					#		# #ignore the first and 10th row
					#	} else {
					#		Temp8x8 <- rbind(Temp8x8, currTemp[i,])
							#keep the relevant rows
							#note: should have 4320 rows x 8 columns
					#	}
					#}
					#Temp8x8 <- Temp8x8[-1,]
					
					#if (nrow(Temp8x8) == 4320 && ncol(Temp8x8) == 8) {
						# write.csv(Temp8x8, file=paste(eightDir, user, coverType, stateType, gestureType, ".csv", sep=""), row.names = FALSE)
					# }
					print("found file")
					framevals <- c("framesum", "col", "row")
					print(paste("the file has this many rows: ", nrow(currTemp), sep=""))
					for (j in 0:((nrow(currTemp)/10)-1)) { 					#431 to get all 4320 rows
						framestart <- (10*j) + 1
						frameend <- (10*j) + 10
						frametmp <- currTemp[framestart:frameend,]
						#framesum <- c(framesum, sum(frametmp))
						
						colcentroid<-centcol(currTemp[framestart:frameend,])
						
						rowcentroid<-centrow(currTemp[framestart:frameend,])
						#if(!between1and10(colcentroid) || !between1and10(rowcentroid)) {
						#	print(paste(substrateType, coverType, gestureType, framestart, frameend, "fails"))
						#}
						thisframe <- c(sum(frametmp), colcentroid, rowcentroid)
						framevals<-rbind(framevals, thisframe)
					}
					#framesum <- framesum[-1]
					#length(framesum)
					#if ((nrow(framevals) == 540) || (nrow(framevals) == 1080)) {
						#setwd(framesumDir)
						#finalfilename <- paste(user, substrateType, coverType, gestureType, ".csv", sep="")
						write.table(framevals, file=paste(framesumDir, userID, substrateType, coverType, gestureType, ".csv", sep=""), row.names=FALSE, col.names=FALSE)
					#}} 
				}		
			}
		}
	}
}