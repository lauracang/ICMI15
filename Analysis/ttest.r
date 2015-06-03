setwd("C:/Users/laura/Desktop/ICMI/Touch Data/notouch12/")

alltouch1<-read.csv("alltouchinstudy1.csv", header=TRUE)
alltouch2<-read.csv("alltouchinstudy2.csv", header=TRUE)

Part1ID<-c("140729-1", "140729-2", "140729-3", "140729-4", "140729-5", "140729-6", "140729-7", "140729-8", "140729-9", "140729-10")

Part2ID<-c("2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17")

gestureID<-c("constant", "pat", "scratch", "rub", "stroke", "tickle")

study1t<-c(1,2,3,4,5,6,7,8,9,10)

study1p<-c(1,2,3,4,5,6,7,8,9,10)

study1d<-c(1,2,3,4,5,6,7,8,9,10)

study2t<-c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)

study2p<-c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)

study2d<-c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)



for (gesture in 1:6) {
	gestureType<-gestureID[gesture]
	gestureFile1<-alltouch1[alltouch1$gesture == gestureType,]
	gestureFile2<-alltouch2[alltouch2$gesture == gestureType,]
	tlist1 <- "ignore"
	plist1 <- "ignore"
	dlist1 <- "ignore"
		
	tlist2<-"ignore"
	plist2 <- "ignore"
	dlist2 <- "ignore"
	
	for (sub1 in 1:10) {
		subject1 <- Part1ID[sub1]
		gestureUser1 <- gestureFile1[gestureFile1$user == subject1,]
		tstat1<-t.test(gestureUser1$framesum, gestureFile1$framesum)
		dstat1<-cohen.d(gestureUser1$framesum, gestureFile1$framesum)
		tlist1<-c(tlist1, tstat1$statistic)
		plist1<-c(plist1, tstat1$p.value)
		dlist1<-c(dlist1, dstat1$estimate)
	}
	study1t<-cbind(study1t, tlist1[-1])
	study1p<-cbind(study1p, plist1[-1])
	study1d<-cbind(study1d, dlist1[-1])
	
	for (sub2 in 1:16) {
		subject2 <- Part2ID[sub2]
		gestureUser2 <- gestureFile2[gestureFile2$user == subject2,]
		tstat2<-t.test(gestureUser2$framesum, gestureFile2$framesum)
		dstat2<-cohen.d(gestureUser2$framesum, gestureFile2$framesum)
		tlist2<-c(tlist2, tstat2$statistic)
		plist2<-c(plist2, tstat2$p.value)
		dlist2<-c(dlist2, dstat2$estimate)
	}
	study2t<-cbind(study2t, tlist1[-1])
	study2p<-cbind(study2p, plist1[-1])
	study2d<-cbind(study2d, dlist1[-1])
}
colnames(study1t)<-c("subject", gestureID)
colnames(study1p)<-c("subject", gestureID)
colnames(study1d)<-c("subject", gestureID)
colnames(study2t)<-c("subject", gestureID)
colnames(study2p)<-c("subject", gestureID)
colnames(study2d)<-c("subject", gestureID)

write.table(study1p, "study1p.csv", sep=",", row.names=FALSE)
write.table(study1t, "study1t.csv", sep=",", row.names=FALSE)
write.table(study1d, "study1d.csv", sep=",", row.names=FALSE)
write.table(study2p, "study2p.csv", sep=",", row.names=FALSE)
write.table(study2t, "study2t.csv", sep=",", row.names=FALSE)
write.table(study2d, "study2d.csv", sep=",", row.names=FALSE)



