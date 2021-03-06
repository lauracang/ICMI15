dir<-"C:/Users/Laura/Desktop/Other Stuff/test/"
userIDtrain<-c("140729-4", "140729-8", "140729-7", "140729-5", "140729-10", "140729-3", "140729-6")
#note: 5 is missing foam-none condition
#note: 10 missing curve fur constant
#note: 3 is missing foam none rub
#note: 6 is missing foam none rub
userTrain<-c("P4", "P8", "P7", "P5", "P10", "P3", "P6")

userIDtest<-c("140729-1", "140729-9", "140729-2")
#note: 2 missing none fur constant
userTest<-c("T1", "T9", "T2")
substrateID<-c("curve", "foam", "none")
coverID<-c("fur", "long", "none", "short")
gestureID<-c("constant", "notouch", "pat", "rub", "scratch", "stroke", "tickle")

cellnames<-"cell1"
for(b in 2:64) {
	namecell<-paste("cell", b, sep="")
	cellnames<-c(cellnames, namecell)
}
finalfile<-1
for(t in 2:68) {
	finalfile<-c(finalfile, t)
}

for(z in 1:7){
	userID<-userIDtrain[z]
	#userID<-"140729-6"
	#userID<-"140729-10"
	
	user<-userTrain[z]
	#user<-"P6"
	#user<-"P10"

	toDir<-paste(dir, sep="")
	currFolder<-paste(dir, userID, sep="")
	#setwd(currFolder)
	for(y in 1:3) { 			#substrate
		#for (x in 1:4) {		#cover
		for (x in 1:4){
			#for (w in 1:7) {	#gesture
			for (w in 1:7) {
				if (z == 4 && y == 2 && x == 3) {}  #note: 5 is missing foam-none condition
				else if (z == 5 && y == 1 && x == 1 && w == 1) {} #note: 10 missing curve fur constant
				else if (z == 6 && y == 2 && x == 3 && w == 4) {} #note: 3 is missing foam none rub
				else if (z == 7 && y == 2 && x == 3 && w == 4) {} #note: 6 is missing foam none rub
				else {
					currFile<-paste(userID, substrateID[y], coverID[x], gestureID[w], ".csv", sep="")
									
					setwd(currFolder)
					
					filename<-read.csv(currFile, header=FALSE)
					filename<-filename[,2:9]	#cut outside 2 cols
					filename64<-c(1,2,3,4,5,6,7,8)
					for(i in 1:5400) {
						if(i%%10 == 0 || i%%10 == 1) {}		#cut 1 and 10 rows
						else {
							filename64<-rbind(filename64, filename[i,])
							#keep only rows 2:9 per frame
						}
					}
					filename64<-filename64[-1,]	#remove first row of 8
					filename64<-1023-filename64	#reverse
					filenameentry<-1			#set first element
					for (i in 2:64) {
						filenameentry<-c(filenameentry, i)
					}							#expect 64 elements
					#filenameentry = row of 1:64
					filename432<-filenameentry	#filename54 = row of 1:64
					filenameentry<-0
					
					for(i in 0:431){
						filenameentry<-1
						for(j in 55:62) { #1-54, 55-108, 
							filenameentry<-c(filenameentry, filename64[i*8+j,])
						}
						filenameentry<-filenameentry[-1]
						filename432<-rbind(filename432, filenameentry)
					}
					filename432<-filename432[-1,]	#filename54 = 54 rows of 64 columns
					#colnames(filename432)<-cellnames
		
					participant<-user
					
					substrate<-substrateID[y]
					#substrate<-"curve"
					#substrate<-"none"
					
					cover<-coverID[x]
					#cover<-"fur"
					#cover<-"short"
					gesture<-gestureID[w]
					#gesture<-NA
					for (a in 1:431){
						participant<-c(participant, user)
						substrate<-c(substrate, substrateID[y])
						#substrate<-c(substrate, "curve")
						cover<-c(cover, coverID[x])
						#cover<-c(cover, "fur")
						gesture<-c(gesture, gestureID[w])
						#gesture<-c(gesture, NA)
					}
					filename432<-cbind(participant, substrate, cover, gesture, filename432)
					finalfile<-rbind(finalfile, filename432)
					#setwd(toDir)

					#write.table(filename432, "train.csv", sep=",", row.names=FALSE, col.names=FALSE, append=TRUE)
				}
			}
		}
	}
}
setwd(toDir)
finalfile<-finalfile[-1,]
colnames(finalfile)<-c("ParticipantID", "Substrate", "Cover", "Gesture", cellnames)
write.table(finalfile, "trainset.csv", sep=",", row.names=FALSE, col.names=TRUE)
#data<-read.csv("train.csv", header = FALSE)
#colnames(data)<-c("ParticipantID", "Substrate", "Cover", "Gesture", cellnames)
#write.table(data, "trainset.csv", sep=",", row.names=FALSE, col.names=TRUE)