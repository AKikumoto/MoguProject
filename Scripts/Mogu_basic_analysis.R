# MoguProject
# LAST UPDATE: "Sat Dec 23 11:32:42 2023"
# NOTE:
# -
# ==============================================================================

# Removing everything from workspace
graphics.off()
rm(list = ls(all = TRUE))

# Load libraries
library(data.table)
library(tidyverse)
library(broom)
library(RColorBrewer)
library(scales)
library(stringr)
library(psych)
library(gt)

# Path
fsep<-.Platform$file.sep;
Dir_Main<-path.expand("~/Dropbox/TEMPORARY HOLDER/Mogu_Project")
Dir_Data<-file.path(Dir_Main,"RawData")

# Load data
setwd(Dir_Data)
ds <- fread("MoguData.csv")
ds[,date:=as.Date(ds$date)]

#===============================================================================
#Statistics
#===============================================================================

# Table of raw data
gt(ds) %>% tab_header(
  title = "Record of Mogu Pooping",
  subtitle = glue::glue(sprintf("{%s} to {%s}",first(ds$date),last(ds$date)))
) 


# 
describe(ds) %>% gt()


#===============================================================================
#Plot
#===============================================================================
theme_set(theme_bw(base_size = 16))
CSCALE_YlGnBu = (brewer.pal(9,"YlGnBu"));
CSCALE_BLUE = (brewer.pal(9,"Blues"));


quartz(width=8,height=6) 
ggplot(data=ds,aes(x=date,y=total_poops)) + 
  #geom_hline(yintercept = 81,color='red')+
  geom_text(aes(0,h,label = "Average", vjust = -1))
  geom_hline(yintercept = mean(ds$total_poops), linetype=2, title='mean')+
  #Main layer-------------------------
  geom_point(color=CSCALE_YlGnBu[8],size=4.5)+
  geom_line(color=CSCALE_YlGnBu[8],size=0.75)+
  #Axis & label-----------------------
  #coord_cartesian(ylim=c(375,680))+
  #scale_y_continuous(breaks=seq(0,1000,50))+
  #coord_cartesian(ylim=c(0,8))+scale_y_continuous(breaks=c(0,8))+
  #ylab("Response time (ms)")+xlab("Session")+
  #ylab("Error (p)")+xlab("Session")+
  ylab("Total poops (count)")+xlab("Dates")
