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


ReedyData <- read.csv(file="C:/Users/ahowlader/Desktop/Noaa Tide Data/ReedyNoaaPrediction2012.csv", header=TRUE, sep=",")
DATETIME<-ReedyData$DATETIME
Tide<-ReedyData$Prediction
ReedyData<-data.frame(DATETIME,Tide)
ReedyData<-na.omit(ReedyData)
ReedyData$DATETIME=as.POSIXct(strptime(ReedyData$DATETIME, '%m/%d/%Y %H:%M'))
startDate=as.POSIXct('2012-01-01 00:00:00')
endDate=as.POSIXct('2012-01-10  00:00:00')
ReedyData<-subset(ReedyData,ReedyData$DATETIME >=startDate & ReedyData$DATETIME<=endDate)
Peak1<-peaks(ReedyData$Tide)
Data3<- ReedyData[Peak1$x, ]  


ShipJohnData <- read.csv(file="C:/Users/ahowlader/Desktop/Noaa Tide Data/ShipJohnNoaaPrediction2012.csv", header=TRUE, sep=",")
Time<-ShipJohnData$DATETIME
Tide<-ShipJohnData$Prediction
ShipJohnData<-data.frame(Time,Tide)
ShipJohnData<-na.omit(ShipJohnData)
ShipJohnData$Time=as.POSIXct(strptime(ShipJohnData$Time, '%m/%d/%Y %H:%M'))
ShipJohnData<-subset(ShipJohnData,ShipJohnData$Time >=startDate & ShipJohnData$Time<=endDate)
peak2<- peaks(ShipJohnData$Tide)
Data4<- ShipJohnData[peak2$x, ]  


p<-ggplot() + geom_line(aes(x = DATETIME, y =Tide,colour="#56b4e9"),size=.5, data = ReedyData)
#p<-ggplot()
p <- p + labs(x = "Time", y = "Tide")
p<-p+geom_line(aes(x = Time, y =Tide,color="brown"),size=.5,data=ShipJohnData)+scale_color_identity(name = "Tide", labels = c( "Ship John Shoal","Reedy"),breaks=c("brown", "#56b4e9"),guide="legend")+theme(legend.position = "right",legend.direction = "vertical")
p<-p+geom_point(aes(x = DATETIME, y =Tide,color="black"),size=2,data=Data3)
p<-p+geom_point(aes(x = Time, y =Tide,color="black"),size=2,data=Data4)

# #p<-p + scale_x_date(breaks = "1 month")
# p<- p+geom_line()+ stat_peaks(colour = "red") +
#   stat_valleys(colour = "blue")



p<-p+theme_bw()
p<-p + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()+theme_bw())
p<-p+theme(axis.text=element_text(size=10),
           axis.title=element_text(size=10,face="bold"))
p<-p+theme(legend.title=element_text(size=18), 
           legend.text=element_text(size=14))
#p<- p + ylim(0,30)
diff<-difftime(Data3$DATETIME,Data4$Time)
diff<- data.frame(diff)
#time difference in Reedy and ship john is 90 minutes 2012
#time difference in Reedy and ship john is 1.3 hours 2012

show(p)
ggsave(file="CompareSR1.pdf", width=15, height=10, dpi=300)

