coverID <- c("cover", "none")
stateID <- c("dynamic", "static")
gestureID <- c("constant", "notouch", "pat", "rub", "scratch", "stroke", "tickle")
userID <- c("1")

user <- paste("150505-", userID[1], sep="")

eightDir <- paste("C:/Users/laura/Desktop/ICMI/Touch Data/",user, "/8x8/", sep = "")
framesumDir <- paste("C:/Users/laura/Desktop/ICMI/Touch Data/", user, "/framesum/", sep="")


for (cover in 1:2) {
	coverType <- coverID[cover]
	for (state in 1:2) {
		stateType <- stateID[state]
		for (gesture in 1:7) {
			gestureType <- gestureID[gesture]
			setwd(eightDir)
			currFile <- paste(user, coverType, stateType, gestureType, ".csv", sep="")
			#currTemp <- read.csv(currFile, header=FALSE)
			#use header=FALSE if using original file; use header=TRUE if using amended file
			currTemp <- read.csv(currFile, header = TRUE) 	
			
			
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
			
			framesum <- 0
			for (j in 0:539) { 					#431 to get all 4320 rows
				framestart <- (8*j) + 1
				frameend <- (8*j) + 8
				frametmp <- currTemp[framestart:frameend,]
				framesum <- c(framesum, sum(frametmp))
			}
			framesum <- framesum[-1]
			#length(framesum)
			if (length(framesum) == 540) {
				write.csv(framesum, file=paste(framesumDir, user, coverType, stateType, gestureType, ".csv", sep=""), row.names=FALSE)
			}
			
		}
	}
}