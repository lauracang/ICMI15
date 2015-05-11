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


coverID <- c("cover", "none")
stateID <- c("dynamic", "static")
gestureID <- c("constant", "notouch", "pat", "rub", "scratch", "stroke", "tickle")
#botUserID <- c("02", "03", "04", "05", "06", "07", "08", "13", "14" )
#manUserID <- c("09", "10", "11", "12", "15", "16", "17")
userID <- c("01","02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17")
#userID <- c("08", "09", "10", "11", "12", "13", "14", "15", "16", "17")
for (subject in 8:17) {

	user <- userID[subject]
	
	if (user == "09" || user == "10" || user == "11" || user == "12" || user == "15" || user == "16" || user == "17" ) {
		controller = "man"
	} else {
		controller = "bot"
	}
	
	startDir <- paste("C:/Users/Laura/Desktop/ICMI/Touch Data/",user, controller,"/", sep = "")
	framesumDir <- "C:/Users/Laura/Desktop/ICMI/Touch Data/allframes/"

	

	for (cover in 1:2) {
		coverType <- coverID[cover]
		for (state in 1:2) {
			stateType <- stateID[state]
			for (gesture in 1:7) {
				gestureType <- gestureID[gesture]
				setwd(startDir)
				
					currFile <- paste("150505-", subject, coverType, stateType, gestureType, ".csv",sep="")
					print(paste("Processing file: ", currFile, sep=""))
					currTemp <- read.csv(currFile, header=FALSE) 
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
					
					framevals <- c("framesum", "col", "row")
					for (j in 0:((nrow(currTemp)/10)-1)) { 					#431 to get all 4320 rows
						framestart <- (10*j) + 1
						frameend <- (10*j) + 10
						frametmp <- currTemp[framestart:frameend,]
						#framesum <- c(framesum, sum(frametmp))
						
						colcentroid<-centcol(currTemp[framestart:frameend,])
						
						rowcentroid<-centrow(currTemp[framestart:frameend,])
						if(!between1and10(colcentroid) || !between1and10(rowcentroid)) {
							print(paste(substrateType, coverType, gestureType, framestart, frameend, "fails"))
						}
						thisframe <- c(sum(frametmp), colcentroid, rowcentroid)
						framevals<-rbind(framevals, thisframe)
					}
					#framesum <- framesum[-1]
					#length(framesum)
					#if ((nrow(framevals) == 540) || (nrow(framevals) == 1080)) {
						write.csv(framevals, file=paste(framesumDir, user, controller, coverType, stateType, gestureType, ".csv", sep=""), row.names=FALSE)
					#}} 
				
				
			}
		}
	}
}