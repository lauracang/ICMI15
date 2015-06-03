
direct1<-"C:/Users/laura/Desktop/ICMI/Challenge/Gesture Data/test/all frames/"
direct2<-"C:/Users/laura/Desktop/ICMI/Touch Data/allframes/"
todirect<-"C:/Users/laura/Desktop/ICMI/Touch Data/notouch12/"

Part1ID<-c("140729-1", "140729-2", "140729-3", "140729-4", "140729-5", "140729-6", "140729-7", "140729-8", "140729-9", "140729-10")
cover1ID<-c("fur", "long", "none", "short")
substrate1ID<-c("curve", "foam", "none")
#note: 5 is missing foam-none condition
#note: 10 missing curve fur constant
#note: 3 is missing foam none rub
#note: 6 is missing foam none rub
#note: 2 missing none fur constant

Part2ID<-c("02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17")
#note: 07 is missing none static notouch
#if (user == "09" || user == "10" || user == "11" || user == "12" || user == "15" || user == "16" || user == "17" ) {
#		controller = "man"
#	} else {
#		controller = "bot"
#	}
cover2ID<-c("cover", "none")
state2ID<-c("static", "dynamic")

gestureID<-c("constant", "pat", "scratch", "rub", "stroke", "tickle")

# setwd(direct1)
# for(user1 in 1:10) {
	# participant<-Part1ID[user1]
	# for (cover1 in 1:4) {
		# furcover<-cover1ID[cover1]
		# for(substrate1 in 1:3) {
			# substrate<-substrate1ID[substrate1]
			# #for(gesture in 1:7) {
				# #gestureType <- gestureID[gesture]
				# gesture<-"notouch"
				# currFile<-paste(participant, substrate, furcover, gesture, ".csv", sep="")
				# readFile<-read.csv(currFile, header=TRUE)
				
			# #}
		# }
	# }
# }

setwd(direct1)
alltouchFile <- c(1,2,3,4,5,6,7)

for (user1 in 1:10) {
	user<-Part1ID[user1]
	for (substrate1 in 1:3) {
		substrate<-substrate1ID[substrate1]
		for (cover1 in 1:4) {
			cover<-cover1ID[cover1]
			for (gesture in 1:6) {
				gestureType <- gestureID[gesture]
				if (user1 == 2 && substrate == "none" && cover == "fur" && gestureType == "constant") {}
				else if (user1 == 10 && substrate == "curve" && cover == "fur" && gestureType == "constant") {}
				else if (user1 == 3 && substrate == "foam" && cover == "none" && gestureType == "rub") {}
				else if (user1 == 6 && substrate == "foam" && cover == "none" && gestureType == "rub") {}
				else if (user1 == 5 && substrate == "foam" && cover == "none") {}
				#note: 5 is missing foam-none condition
				#note: 10 missing curve fur constant
				#note: 3 is missing foam none rub
				#note: 6 is missing foam none rub
				#note: 2 missing none fur constant
				else {
					currFile<-paste(user, substrate, cover, gestureType, ".csv", sep="")
					print(paste("Processing file: ", currFile, sep=""))
					readFile<-read.table(currFile, header=FALSE, sep=" ")
					readFile<-readFile[-1,]
					readFile<-readFile[-1,]
					userList<-user
					coverList<-cover
					substrateList<-substrate
					gestureList<-gestureType
					for (n in 1:(nrow(readFile)-1)) {
						userList<-c(userList, user)
						coverList<-c(coverList, cover)
						substrateList<-c(substrateList, substrate)
						gestureList<-c(gestureList, gestureType)
					}
					readFile<-cbind(readFile, userList, substrateList, coverList, gestureList)
					alltouchFile<-rbind(alltouchFile, readFile)
				}
			}
		}
	}
}

colnames(alltouchFile)<-c("framesum", "x", "y", "user", "substrate", "cover", "gesture")
setwd(todirect)
write.table(alltouchFile[-1,], "alltouchinstudy1.csv", sep=",", row.names=FALSE)