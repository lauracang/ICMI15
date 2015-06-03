direct1<-"C:/Users/laura/Desktop/ICMI/Challenge/Gesture Data/test/all frames/"
direct2<-"C:/Users/laura/Desktop/ICMI/Touch Data/allframes/"
todirect<-"C:/Users/laura/Desktop/ICMI/Touch Data/notouch12/"

Part1ID<-c("140729-1", "140729-2", "140729-3", "140729-4", "140729-5", "140729-6", "140729-7", "140729-8", "140729-9", "140729-10")
cover1ID<-c("fur", "none", "long", "short")
substrate1ID<-c("none", "foam", "curve")
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

gestureID<-c("notouch", "constant", "pat", "scratch", "rub", "stroke", "tickle")

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

setwd(direct2)
alltouchFile <- c("framesum", "x", "y", "user", "control", "cover", "state")

for (user2 in 1:16) {
	user<-Part2ID[user2]
	if (user == "09" || user == "10" || user == "11" || user == "12" || user == "15" || user == "16" || user == "17" ) {
		controller = "man"
	} else {
		controller = "bot"
	}
	for (state2 in 1:2) {
		state<-state2ID[state2]
		for (cover2 in 1:2) {
			cover<-cover2ID[cover2]
			if (user == "07" && state == "static" && cover == "none") {}
			else {
				gesture<-"notouch"
				currFile<-paste(user, controller, cover, state, gesture, ".csv", sep="")
				print(paste("Processing file: ", currFile, sep=""))
				readFile<-read.csv(currFile, header=FALSE, as.is=TRUE)
				readFile<-readFile[-1,]
				readFile<-readFile[-1,]
				userList<-user
				controlList<-controller
				coverList<-cover
				stateList<-state
				for (n in 1:(nrow(readFile)-1)) {
					userList<-c(userList, user)
					controlList<-c(controlList, controller)
					coverList<-c(coverList, cover)
					stateList<-c(stateList, state)
				}
				readFile<-cbind(readFile, userList, controlList, coverList, stateList)
				notouchFile<-rbind(notouchFile, readFile)
			
			}
		}
	}
}
setwd(todirect)
write.table(notouchFile, "notouch.csv", sep=",", row.names=FALSE, col.names=FALSE)