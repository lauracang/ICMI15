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

coverID <- c("cover", "none")
stateID <- c("dynamic", "static")
gestureID <- c("constant", "notouch", "pat", "rub", "scratch", "stroke", "tickle")
userID <- c("01","02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17")

startDir <- "C:/Users/Laura/Desktop/ICMI/Touch Data/allframes/"
#framesumDir <- "C:/Users/Laura/Desktop/ICMI/Touch Data/allframes/"

setwd(startDir)
windowFeatures <- c("max", "min", "mean", "median", "var", "totalvar", "auc", "Xmax", "Xmin", "Xmean", "Xmedian", "Xvar", "Xtotalvar", "Xauc", "Ymax", "Ymin", "Ymean", "Ymedian", "Yvar", "Ytotalvar", "Yauc", "cover", "state", "subject", "control", "type")

for (subject in 2:17) {

	user <- userID[subject]
	
	if (user == "09" || user == "10" || user == "11" || user == "12" || user == "15" || user == "16" || user == "17" ) {
		controller = "man"
	} else {
		controller = "bot"
	}

	for (cover in 1:2) {
		coverType <- coverID[cover]
		for (state in 1:2) {
			stateType <- stateID[state]
			for (gesture in 1:7) {
				gestureType <- gestureID[gesture]
				if (user == "07" && coverType == "none" && stateType == "static" && gestureType == "notouch") {
				} else {
					currFile<-paste(user, controller, coverType, stateType, gestureType, ".csv", sep="")
					print(paste("processing file: ", currFile, sep=""))
					currTemp<-read.csv(currFile,header=FALSE)
					#thisname<-currTemp[1,]
					currTemp<-currTemp[-1,]
					currTemp<-currTemp[-1,]
					
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
						
						framerow<-c(frametuple1, frametuple2, frametuple3, coverType, stateType, user, controller, gestureType)
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
write.csv(windowFeatures, "allFrames1.csv", row.names=FALSE)