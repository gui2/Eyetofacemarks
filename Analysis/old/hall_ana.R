data <- read.csv("~/R/hall/hall_n=59.csv")

data$perfix <- round(data$PerFixPostStart*30)/30
ms <- aggregate(perfix ~ Group,data=data,mean)
plot(1:3,ms$perfix,xlim=c(.75,3.25),bty="n",col="red",pch="-",cex=4,xaxt="n",
	ylim=c(0,1),xlab="Participant Group",ylab="Proportion Face Fixation")
stripchart(perfix ~ Group,add=T,pch=20,
	vertical=TRUE,method="stack",data=data)
axis(1,at=1:3,labels=c("Dev. Disord.","FXS Females","FXS Males"))