rm(list=ls())
source("~/Projects/R/mcf.useful.R")
all.data <- read.csv("~/Projects/R/hall/data/by_subjects_11-17.csv")

###########
## exclusion criteria
include <- all.data$UsableDataMin > 2
data <- subset(all.data,include)

descriptives <- aggregate(cbind(FacePercentAfterStart,UsableDataMin,Age,IQ) ~ Group,data,mean)
descriptives$n <- aggregate(Name ~ Group,data,length)

########## 
## plots


### BASIC PLOT
ms <- aggregate(FacePercentAfterStart ~ Group,data,na.mean)
ms$cih <- aggregate(FacePercentAfterStart ~ Group,data,ci.high)$FacePercentAfterStart
ms$cil <- aggregate(FacePercentAfterStart ~ Group,data,ci.low)$FacePercentAfterStart
  
qplot(Group,FacePercentAfterStart,data=data,colour=Group,position=position_jitter(width=.05),
      xlab="Participant Group",ylab="Proportion Face Looking") + 
        geom_pointrange(aes(x=Group,y=FacePercentAfterStart,ymin=FacePercentAfterStart-cil,ymax=FacePercentAfterStart+cih,colour="Mean +/- 95% CI"),data=ms,
                        position=position_dodge(width=.2)) +
  scale_colour_manual(name="Participant Group",
                      values= c('DD_Participants' = 'red','FXS_Females' = 'green',
                                'FXS_Males' = 'blue','Mean +/- 95% CI' = 'black')) + 
  theme_bw() + plot.style

### PLOT BY IQ or AGE

qplot(Age,FacePercentAfterStart,data=data,colour=Group,
	geom=c("point","smooth"),method="lm",se=F,
	ylab="Proportion Face Looking") + 
	theme_bw() + plot.style

qplot(IQ,FacePercentAfterStart,data=data,colour=Group,
	geom=c("point","smooth"),method="lm",se=F,
	ylab="Proportion Face Looking") + 
	theme_bw() + plot.style

###########
## stats
hist(data$FacePercentAfterStart)
summary(lm(FacePercentAfterStart ~ Group + IQ + Age,data=data))

summary(lm(FacePercentAfterStart ~ Group + IQ,data=data))
summary(lm(FacePercentAfterStart ~ Group * IQ,data=data))


full.lm <- lm(FacePercentAfterStart ~ Group * IQ * Age,data=data)
full.slm <- step(full.lm,direction="both")


summary(lm(FacePercentAfterStart ~ Group,data=data))