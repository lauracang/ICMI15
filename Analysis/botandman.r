
# botID <- c("02", "03", "04", "05", "06", "07", "08", "13", "14")
# manID <- c("09", "10", "11", "12", "15", "16", "17")
coverID <- c("cover", "none")
stateID <- c("dynamic", "static")
gestureID <- c("constant", "notouch", "pat", "rub", "scratch", "stroke", "tickle")
userID <- c("01", "02bot", "03bot", "04bot", "05bot", "06bot", "07bot", "08bot", "09man", "10man", "11man", "12man", "13bot", "14bot", "15man", "16man", "17man")
botmanID <- c("pilot", "bot", "bot", "bot", "bot", "bot", "bot", "bot", "man", "man", "man", "man", "bot", "bot", "man", "man", "man")
setwd("C:/Users/laura/Desktop/ICMI/Touch Data/allframes/")
botset <- -1
manset <- -1
for (subject in 2:length(userID)) {
	user <- userID[subject]
	for (cover in 1:2) {
		coverType <- coverID[cover]
		for (state in 1:2) {
			stateType <- stateID[state]
			for (gesture in 1:7) {
				gestureType <- gestureID[gesture]
				if (user == "07bot" && coverType == "none" && stateType == "static" && gestureType == "notouch") {
				} else {				
					currFile <- paste(user, coverType, stateType, gestureType, ".csv", sep="")
					print(paste("processing file: ", currFile, sep=""))
					currTemp <- read.csv(currFile, header=FALSE)
					currTemp<-currTemp[-1,]
					currTemp<-currTemp[-1,]
					if (botmanID[subject] == "bot") {
						botset <- c(botset, as.numeric(as.vector(currTemp[55:486,1])))
					} else {
						manset <- c(manset, as.numeric(as.vector(currTemp[55:486,1])))
					}
				}
			}
		}	
	}		
}
write.csv(botset, file = "botset432.csv", row.names=FALSE)
write.csv(manset, file = "manset432.csv", row.names=FALSE)