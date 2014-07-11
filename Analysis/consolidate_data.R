rm(list=ls())
source("~/Projects/R/Ranalysis/useful.R")
setwd("~/Projects/FreeView/Eyetofacemarks/")

d.violajones <- read.csv("Data/viola_jones_data/by_subjects_11-17.csv")
d.dwell <- read.csv("Data/DPM_data/dwell_time.csv")
d.stickiness <- read.csv("Data/DPM_data/stickiness.csv")

## check subjects
sort(d.violajones$Name)
sort(d.dwell$id)
sort(d.stickiness$id)


md <- merge(d.violajones, d.dwell, by.x="Name", by.y="id",all.x=TRUE,all.y=TRUE)
md <- merge(md, d.stickiness, by.x="Name", by.y="id",all.x=TRUE, all.y=TRUE)

write.csv(md,"Data/aggregate_data.csv", row.names=FALSE)
