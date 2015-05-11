between1and8<-function(x) {
	return(x>=0 && x<=8)
}

centrow<-function(x) {
	rowcent <- 0
	totalval <- sum(x)
	if (totalval != 0) {
		for (i in 1:8) {
			for (j in 1:8) {
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
		for (i in 1:8) {
			for(j in 1:8) {
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

framedata1<-c("max", "min", "mean", "median", "variance", "totvar", "auc", "8type")
framedata2<-c("Xmax", "Xmin", "Xmean", "Xmedian", "Xvariance", "Xtotvar", "Xauc", "16type")
framedata3<-c("Ymax", "Ymin", "Ymean", "Ymedian", "Yvariance", "Ytotvar", "Yauc", "type")
coverCol <- "cover"
stateCol <- "state"
gestureCol <- "type"
for (users in 1:length(userID)) {
	user <- paste("150505-", userID[users], sep="")
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
				# write from 8x8 frames to framesum and centroid vectors					#	
				#############################################################################	
				
				# setwd(eightDir)
				# currFile <- paste(user, coverType, stateType, gestureType, ".csv", sep="")
				# currTemp <- read.csv(currFile, header = TRUE) 	
				# framevals <- c(0,0,0)
				# for (j in 0:539) { 					#540 frames of 8 rows each = 4320 rows total
					# framestart <- (8*j) + 1
					# frameend <- (8*j) + 8
					# frametmp <- currTemp[framestart:frameend,]
					# colcentroid<-centcol(currTemp[framestart:frameend,])
					# rowcentroid<-centrow(currTemp[framestart:frameend,])
					# if(!between1and8(colcentroid) || !between1and8(rowcentroid)) {
						# print(paste(substrateType, coverType, gestureType, framestart, frameend, "fails"))
					# }
					# rowvals <- c(sum(frametmp), colcentroid, rowcentroid)
					# framevals <- rbind(framevals,rowvals)
					
				# }
				# framevals <- framevals[-1,]
				# #nrow(framevals)
				# if (nrow(framevals) == 540) {
					# write.csv(framevals, file=paste(framesumDir, user, coverType, stateType, gestureType, ".csv", sep=""), row.names=FALSE)
				# }
				
				#############################################################################
				# from framesum vector to features											#	
				#############################################################################	
				
				setwd(framesumDir)
				currFile <- paste(user, coverType, stateType, gestureType, ".csv", sep="")
				currTemp <- read.csv(currFile, header = TRUE)
				
				#separate into 2 second chunks (ignoring first and last second)
				currTemp <- currTemp[55:486,]
				# framedata1<-c("max", "min", "mean", "median", "variance", "totvar", "auc", "8type")
				# framedata2<-c("Xmax", "Xmin", "Xmean", "Xmedian", "Xvariance", "Xtotvar", "Xauc", "16type")
				# framedata3<-c("Ymax", "Ymin", "Ymean", "Ymedian", "Yvariance", "Ytotvar", "Yauc", "type")
				# coverCol <- "cover"
				# stateCol <- "state"
				# gestureCol <- "type"
				for (l in 0:3) {
					framestart <- (108*l) + 1
					frameend <- (108*l) + 108
					#tuple<-c(foundmax, foundmin, foundmean, foundmedian, foundvariance, foundtotvar, foundauc)
													
					#first col for framesum
					frametmp1 <- currTemp[framestart:frameend,1] 
					frametuple1 <- findtuple(frametmp1)
					framedata1 <- rbind(framedata1, frametuple1)
						
					#2nd col is centCol
					frametmp2 <- currTemp[framestart:frameend,2] 
					frametuple2 <- findtuple(frametmp2)
					framedata2 <- rbind(framedata2, frametuple2)
					
					#3rd col is centRow
					frametmp3 <- currTemp[framestart:frameend,3]			
					frametuple3 <- findtuple(frametmp3)
					framedata3 <- rbind(framedata3, frametuple3)
					
					#add state and cover data
					coverCol <- rbind(coverCol, coverType)
					stateCol <- rbind(stateCol, stateType)
					gestureCol <- rbind(gestureCol, gestureType)
					
				}
				
				#featuredata1<-cbind(framedata1[,1:7], framedata2[,1:7], framedata3[,1:7], coverCol, stateCol, gestureCol)
				#write.csv(featuredata1, file=paste(featuresDir,user,coverType,stateType,gestureType,".csv", sep=""),row.names=FALSE)
				
			
			}
		}
		
	}
	featuredata<-cbind(framedata1[,1:7], framedata2[,1:7], framedata3[,1:7], coverCol, stateCol, gestureCol)
	write.csv(featuredata, file=paste(featuresDir,user,"featureset.csv", sep=""),row.names=FALSE)
}