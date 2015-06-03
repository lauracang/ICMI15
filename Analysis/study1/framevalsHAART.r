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

findtuple<-function(x) {
	foundmax<-max(x)
	foundmin<-min(x)
	foundmean<-mean(x)
	foundmedian<-median(x)
	foundvariance<-var(x)
	foundtotvar<-totalvar(x)
	foundauc<-auc(x)
	tuple<-c(foundmax, foundmin, foundmean, foundmedian, foundvariance, foundtotvar, foundauc)
	return(tuple)
}

coverID<-c("fur", "long", "none", "short")
substrateID<-c("curve", "foam", "none")
gestureID <- c("constant", "notouch", "pat", "rub", "scratch", "stroke", "tickle")
user<- c("140729-4", "140729-8", "140729-7", "140729-5", "140729-10", "140729-3", "140729-6", "140729-1", "140729-2", "140729-9")
userName <- c("P4", "P8", "P7", "P5", "P10", "P3", "P6", "P1", "P2", "P9")

startDir <- "C:/Users/laura/Desktop/ICMI/Challenge/Gesture Data/test/all frames/"
setwd(startDir)
windowFeatures <- c("max", "min", "mean", "median", "var", "totalvar", "auc", "Xmax", "Xmin", "Xmean", "Xmedian", "Xvar", "Xtotalvar", "Xauc", "Ymax", "Ymin", "Ymean", "Ymedian", "Yvar", "Ytotalvar", "Yauc", "substrate", "cover", "subject", "type")
for(z in 1:10){
	userID<-user[z]
	username<-userName[z]
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
					currFile <- paste(userID, substrateType, coverType, gestureType, ".csv", sep="")					
					currTemp <- read.table(currFile, header=TRUE) 
					print(paste("Processing file: ", currFile, sep=""))
					#use header=FALSE if using original file; use header=TRUE if using amended file
					#currTemp <- read.csv(currFile, header = TRUE) 	
					#thisname<-currTemp[1,]
					
					for (l in 0:3) {
						framestart <- (108*l) + 55
						frameend <- (108*l) + 162
						
						#framesum
						frametmp1 <- as.numeric(as.vector(currTemp[framestart:frameend,1]))
						frametuple1 <- findtuple(frametmp1)
						
						#centCol
						frametmp2 <- as.numeric(as.vector(currTemp[framestart:frameend,2]))
						frametuple2 <- findtuple(frametmp2)
						
						#centRow
						frametmp3 <- as.numeric(as.vector(currTemp[framestart:frameend,3]))			
						frametuple3 <- findtuple(frametmp3)
						
						framerow<-c(frametuple1, frametuple2, frametuple3, substrateType, coverType, username, gestureType)
						windowFeatures<-rbind(windowFeatures, framerow)
					}
					#if (nrow(currTemp > 1000)) { #for larger datafiles
					#	for (m in 5:8) {
					#		framestart2 <- (108*l) + 55
					#		frameend2 <- (108*l) + 162
					#							
					#		#framesum
					#		frametmp1 <- as.numeric(as.vector(currTemp[framestart2:frameend2,1]))
					#		frametuple1 <- findtuple(frametmp1)
					#	
					#		#centCol
					#		frametmp2 <- as.numeric(as.vector(currTemp[framestart2:frameend2,2])) 
					#		frametuple2 <- findtuple(frametmp2)
					#	
					#		#centRow
					#		frametmp3 <- as.numeric(as.vector(currTemp[framestart2:frameend2,3]))		
					#		frametuple3 <- findtuple(frametmp3)
					#	
					#		framerow<-c(frametuple1, frametuple2, frametuple3, coverType, stateType, user, controller, gestureType)
					#		windowFeatures<-rbind(windowFeatures, framerow)
					#	}
					#}
				}
			}
		}
	}
}
setwd("C:/Users/laura/Desktop/ICMI/Challenge/Gesture Data/test/")
write.csv(windowFeatures, "allFramesHAART.csv", row.names=FALSE)