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


coverID <- c("cover", "none")
stateID <- c("dynamic", "static")
gestureID <- c("constant", "notouch", "pat", "rub", "scratch", "stroke", "tickle")
userID <- c("1")

user <- paste("150505-", userID[1], sep="")
#rootDir <- paste("C:/Users/laura/Desktop/ICMI/Touch Data/", user, "/raw", sep = "") 
#dataDir <- paste("C:/Users/laura/Desktop/ICMI/Touch Data/", user, "/data/", sep = "")
#eightDir <- paste("C:/Users/laura/Desktop/ICMI/Touch Data/",user, "/8x8/", sep = "")
framesumDir <- paste("C:/Users/laura/Desktop/ICMI/Touch Data/", user, "/framesum/", sep="")
featuresDir <- paste("C:/Users/laura/Desktop/ICMI/Touch Data/", user, "/features/", sep="")

for (cover in 1:2) {
	coverType <- coverID[cover]
	for (state in 1:2) {
		stateType <- stateID[state]
		for (gesture in 1:7) {
			gestureType <- gestureID[gesture]
			
			#############################################################################
			# set from raw to 8x8 frames												#	
			#############################################################################	
			
			#setwd(rootDir)
			#currFile <- paste(user, coverType, stateType, gestureType, ".csv", sep="")
			#currTemp <- read.csv(currFile, header=FALSE)
			#use header=FALSE if using original file; use header=TRUE if using amended file
			#currTemp <- read.csv(currFile, header = TRUE) 	
			
			
			# currTemp <- 1023 - currTemp		#invert data to be 0 - 1023 rather than 1023 - 0
			# write.csv(currTemp, file=paste(dataDir, user, coverType, stateType, gestureType, ".csv", sep= ""), row.names=FALSE)
			# currTemp <- currTemp[,2:9]		#take middle 8 columns
			
			# Temp8x8 <- c(1,2,3,4,5,6,7,8) 	#set first row to define col size (to be deleted later)
			
			# for (i in 1:5400) {				#take middle 8 rows per frame
				# if (i%%10 == 1 || i%%10 == 0) {
					# #ignore the first and 10th row
				# }			
				# else {
					# Temp8x8 <- rbind(Temp8x8, currTemp[i,])
					# #keep the relevant rows
					# #note: should have 4320 rows x 8 columns
				# }
			# }
			# Temp8x8 <- Temp8x8[-1,]
			
			# if (nrow(Temp8x8) == 4320 && ncol(Temp8x8) == 8) {
				# write.csv(Temp8x8, file=paste(eightDir, user, coverType, stateType, gestureType, ".csv", sep=""), row.names = FALSE)
			# }
			
			#############################################################################
			# write from 8x8 frames to framesum vector									#	
			#############################################################################	
			
			# setwd(eightDir)
			# currFile <- paste(user, coverType, stateType, gestureType, ".csv", sep="")
			# currTemp <- read.csv(currFile, header = TRUE) 	
			# framesum <- 0
			# for (j in 0:539) { 					#431 to get all 4320 rows
				# framestart <- (8*j) + 1
				# frameend <- (8*j) + 8
				# frametmp <- currTemp[framestart:frameend,]
				# framesum <- c(framesum, sum(frametmp))
			# }
			# framesum <- framesum[-1]
			# #length(framesum)
			# if (length(framesum) == 540) {
				# write.csv(framesum, file=paste(framesumDir, user, coverType, stateType, gestureType, ".csv", sep=""), row.names=FALSE)
			# }
			
			#############################################################################
			# from framesum vector to features											#	
			#############################################################################	
			
			setwd(framesumDir)
			currFile <- paste(user, coverType, stateType, gestureType, ".csv", sep="")
			currTemp <- read.csv(currFile, header = TRUE)
			
			#separate into 2 second chunks (ignoring first and last second)
			currTemp <- currTemp[55:486,]
			for (l in 0:3) {
				framestart <- (108*l) + 1
				frameend <- (108*l) + 108
				
				#no num for framesum
				frametmp <- cfFtmp[framestart:frameend,] 
				frametuple <- findtupe(frametmp, gestureType)
				frametuple <- findtuple (frametmp, gestureType)
					
				# 1 for centCol
				frametmp1 <- cfFtmp[framestart:frameend,1] 
				frametuple1 <- findtuple(frametmp1, gestureType)
				framedata1 <- rbind(framedata1, frametuple1)
				
				# 2 for centRow
				frametmp2 <- cfFtmp[framestart:frameend,2]			
				frametuple2 <- findtuple(frametmp2, gestureType)
				framedata2 <- rbind(framedata2, frametuple2)
			}
			
		
		
		}
	}
}