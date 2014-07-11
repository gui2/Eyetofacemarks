Fragile-X Free-viewing Conversation Eye-tracking Analysis
====
  
```{r}  
rm(list=ls())
source("~/Projects/R/Ranalysis/useful.R")
setwd("~/Projects/FreeView/Eyetofacemarks/")
d <- read.csv("Data/aggregate_data_exclusions-6-5.csv")

sum(d$exclude)

d <- subset(d, exclude==0)

## verify match
quartz()
qplot(face.after.start.vj, face.dpm, colour=group,label=id,
      geom="text",
      data=d) + 
#   geom_smooth(method="lm",) + 
  ylim(c(0,1)) 

## group-level analyses
ms <- ddply(d, .(group), summarise, 
      face.looking = na.mean(face.dpm),     
      face.cih = ci.high(face.dpm), 
      face.cil = ci.low(face.dpm))

quartz()
qplot(group,face.looking, geom=c("bar","linerange"),
      fill=group,
      ymin=face.looking-face.cil,
      ymax=face.looking+face.cih,
      data=ms) + 
  ylim(c(0,1))

# or by individuals
qplot(group, face.dpm, data=d, position=position_jitter(.1), col=group) + 
  geom_linerange(aes(x=group, y=face.looking, ymin=face.looking-face.cil,
                      ymax=face.looking+face.cih), col="black", data=ms) + 
  geom_errorbarh(aes(xmin=as.numeric(group)-.05, xmax=as.numeric(group)+.05, y=face.looking), 
                 data=ms, col="black", height=0, size=2)



## group-level analyses
ms <- ddply(d, .(group), summarise, 
            stickiness = na.mean(stickiness.mean),     
            stickiness.cih = ci.high(stickiness.mean), 
            stickiness.cil = ci.low(stickiness.mean))

quartz()
qplot(group,stickiness, geom=c("bar","linerange"),
      fill=group, 
      ymin=stickiness-stickiness.cil,
      ymax=stickiness+stickiness.cih,
      data=ms) 

## region-level analyses
md <- melt(d, id.var=c("id","group"), measure.var=c("nose","l.eye","r.eye","mouth","l.jaw","r.jaw"))
ms <- ddply(md, .(group,variable), summarise, 
            face.looking = na.mean(value), 
            face.cih = ci.high(value), 
            face.cil = ci.low(value))

quartz()
qplot(variable,face.looking, geom=c("bar","linerange"),
      facets=. ~ group, fill=variable,
      position=position_dodge(width=.9),
      ymin=face.looking-face.cil,
      ymax=face.looking+face.cih,
      data=ms) + 
  ylim(c(0,.3))


### distribution
quartz()
qplot(variable, value, data=md, position=position_jitter(.1), col=variable, 
      facets=.~ group) + 
  geom_linerange(aes(x=variable, y=face.looking, ymin=face.looking-face.cil,
                     ymax=face.looking+face.cih), col="black", data=ms) + 
  geom_errorbarh(aes(xmin=as.numeric(variable)-.25, xmax=as.numeric(variable)+.25, 
                     y=face.looking), col="black",
                 data=ms, height=0, size=2)

quartz()
qplot(variable, value, data=md,  col=variable,
      geom="boxplot",adjust=1,
      facets=.~ group)

## by age and IQ
quartz()
qplot(age, face.dpm, colour=group, data=d) + 
  geom_smooth(method="lm", se=FALSE)

quartz()
qplot(iq, face.dpm, colour=group, data=d) + 
  geom_smooth(method="lm", se=FALSE)

## non-interactive model is best
l1 <- lm(face.dpm ~ iq + group, data=d)
l2 <- lm(face.dpm ~ iq * group, data=d)
anova(l1,l2)
summary(l1)

l1a <- lm(face.dpm ~ age + group, data=d)
l2a <- lm(face.dpm ~ age * group, data=d)
anova(l1a,l2a)
summary(l1a)

##
