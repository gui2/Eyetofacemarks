rm(list=ls())
source("~/Projects/R/mcf.useful.R")
data <- read.csv("~/Projects/R/hall/frame_data_full.csv")
na.mean <- function(x) {mean(x,na.rm=T)}
data$time.binned <- round(data$time.s)
data$face[is.nan(data$face)] <- NA

### make a plot
quartz()
mss <- aggregate(face ~ time.binned + sub + grp,data,na.mean)
ms <- aggregate(face ~ time.binned + grp,mss,na.mean)

qplot(time.binned,face,colour=grp,data=ms[ms$time.binned<250,],geom="point",
      xlab="time (s)", ylab="proportion face looking", ylim=c(0,1)) +
        geom_smooth() + theme_bw() + plot.style

### basic averages
quartz()
mss <- aggregate(face ~ sub + grp,data,na.mean)
ms <- aggregate(face ~ grp,mss,na.mean)
ms$cih <- aggregate(face ~ grp,mss,ci.high)$face
ms$cil <- aggregate(face ~ grp,mss,ci.low)$face
  
qplot(grp,face,data=mss,colour=grp,position=position_jitter(width=.05),
      xlab="Participant Group",ylab="Proportion Face Looking") + 
        geom_pointrange(aes(x=grp,y=face,ymin=face-cil,ymax=face+cih,colour="Mean +/- 95% CI"),data=ms,
                        position=position_dodge(width=.2)) +
  scale_colour_manual(name="Participant Group",
                      values= c('DD_Participants' = 'red','FXS_Females' = 'green',
                                'FXS_Males' = 'blue','Mean +/- 95% CI' = 'black')) + 
  theme_bw() + plot.style

## some stats
basic.glm <- glm(face ~ time.s * grp, family="binomial", data = data)
basic.lmer <- lmer(face ~ time.s * grp + (time.s | sub), family="binomial", data = data)


## exclude subs with missing 
is.good <- function (x) {mean(!is.na(x$face))}
usable <- ddply(data,.(sub,grp), "is.good")

inc <- usable$is.good > .60
inc.subs <- usable$sub[inc]
include <- function(x) {any(x==inc.subs)}

inc.data <- data[sapply(data$sub,include),]

mss <- aggregate(face ~ time.binned + sub + grp,inc.data,na.mean)
ms <- aggregate(face ~ time.binned + grp,mss,na.mean)

quartz()
qplot(time.binned,face,colour=grp,data=ms[ms$time.binned<250,],geom="point",
      xlab="time (s)", ylab="proportion face looking", ylim=c(0,1)) +
        geom_smooth() + theme_bw() + plot.style
