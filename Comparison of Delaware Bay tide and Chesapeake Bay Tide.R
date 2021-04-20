cat("\014") 
rm(list=ls())

library(ggplot2)
library(grid)
library(lubridate)
library(pracma)
library(GCalignR)
library(peakPick)
library(ggfortify)
library(magrittr) 
library(ggpmisc)
library(IDPmisc)


ChesapeakeData <- read.csv(file="C:/Users/ahowlader/Desktop/638901 CBBT, Chesapeake Channel, VA .csv", header=TRUE, sep=",")
DATETIME<-ChesapeakeData$DATETIME
Tide<-ChesapeakeData$Predicted..ft.
ChesapeakeData<-data.frame(DATETIME,Tide)
ChesapeakeData<-na.omit(ChesapeakeData)
ChesapeakeData$DATETIME=as.POSIXct(strptime(ChesapeakeData$DATETIME, '%m/%d/%Y %H:%M',tz="GMT"))
Peak1<-peaks(ChesapeakeData$Tide)
Data3<- ChesapeakeData[Peak1$x, ]  


ShipJohnData <- read.csv(file="C:/Users/ahowlader/Desktop/Ship John.csv", header=TRUE, sep=",")
Time<-ShipJohnData$DATETIME
Tide<-ShipJohnData$Predicted..ft.
ShipJohnData<-data.frame(Time,Tide)
ShipJohnData<-na.omit(ShipJohnData)
ShipJohnData$Time=as.POSIXct(strptime(ShipJohnData$Time, '%m/%d/%Y %H:%M',tz="GMT"))
peak2<- peaks(ShipJohnData$Tide)
Data4<- ShipJohnData[peak2$x, ]  


p<-ggplot() + geom_line(aes(x = DATETIME, y =Tide,colour="red"),size=.5, data = ChesapeakeData)
p <- p + labs(x = "Time", y = "Tide in Feet")
p<-p+geom_line(aes(x = Time, y =Tide,color="yellow"),size=.5,data=ShipJohnData)+scale_color_identity(name = "Tide", labels = c( "8537121 Ship John Shoal, NJ","638901 CBBT, Chesapeake Channel, VA"),breaks=c("yellow", "red"),guide="legend")+theme(legend.position = "right",legend.direction = "vertical")
p<-p+geom_point(aes(x = DATETIME, y =Tide,color="black"),size=2,data=Data3)
p<-p+geom_point(aes(x = Time, y =Tide,color="black"),size=2,data=Data4)




p<-p+theme_bw()
p<-p + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()+theme_bw())
p<-p+theme(axis.text=element_text(size=14),
           axis.title=element_text(size=14,face="bold"))
p<-p+theme(legend.title=element_text(size=18), 
           legend.text=element_text(size=14))
show(p)
ggsave(file="C:/Users/ahowlader/Desktop/Comparison of Tide.pdf", width=15, height=10, dpi=300)

