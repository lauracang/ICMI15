#note: 2 missing none fur constant
#note: 1 is not written as .csv
setwd("C:/Users/Laura/Desktop/Other stuff/test/")
userTest<-c("T1", "T2", "T9")
substrateID<-c("curve", "foam", "none")
coverID<-c("fur", "long", "none", "short")
gestureID<-c("constant", "notouch", "pat", "rub", "scratch", "stroke", "tickle")

for (z in 1 : 3) {
	for (y in 1:3) {
		for (x in 1:4) {
			for (w in 1:7) {
			
				if (z == 2 && y == 3 && x == 1 && w == 1) {}
				else {
					participant<-userTest[z]
					substrate<-substrateID[y]
					cover<-coverID[x]
					gesture<-gestureID[w]
					for (a in 1:431){
						
						participant<-c(participant, userTest[z])
						substrate<-c(substrate, substrateID[y])
						cover<-c(cover, coverID[x])
						gesture<-c(gesture, gestureID[w])	
						
					}
					labelsetrows<-cbind(participant, substrate, cover, gesture)
					write.table(labelsetrows, "labels.csv", sep=",", row.names=FALSE, col.names=FALSE, append=TRUE)
				}
				
			}
		}
	}
}

