library(ggplot2)
library(dplyr)
library(ggimage)
library(magick)
transparent <- function(img) {
  image_fx(img, expression = "0.5*a", channel = "alpha")
}
setwd("~/Desktop/Programming/R/Plots")

Median_Discharge <- read.table(
  "https://waterservices.usgs.gov/nwis/stat/?sites=03075070&statReportType=daily&statTypeCd=median&parameterCd=00060&format=rdb",
  sep="\t", header=TRUE)

Point_Discharge <- read.table(
  "https://waterservices.usgs.gov/nwis/iv/?sites=03075070&parameterCd=00060&startDT=2022-08-15T12:13:18.803-04:00&endDT=2022-09-06T12:13:18.803-04:00&siteStatus=all&format=rdb",
  sep="\t", header=TRUE)


#Point_Discharge<-Point_Discharge[-1,]
#Median_Discharge<-Median_Discharge[-1,]

colnames(Point_Discharge)<-c('Agency','Site','Date','TimeZone','Discharge','Category')
Point_Discharge$Date<-as.POSIXlt.character(Point_Discharge$Date)
Point_Discharge$Date<-as.POSIXct.POSIXlt(Point_Discharge$Date)
Point_Discharge$Discharge<-as.numeric(Point_Discharge$Discharge)

PD_lite <- Point_Discharge[c(rep(FALSE,4),TRUE), ]

PD_lite %>%  #Toggle between 'PD_lite' and 'Point_Discharge' to display full dataset
  ggplot(aes(x=Date, y=Discharge)) +
  geom_area( color="darkblue", fill = "lightblue")+
  geom_line(color = "white") +
  #geom_point() +
  ylab("Discharge in Cubic Ft per second")+
  ggtitle("Monongahela Water Flow") +
  scale_x_datetime(labels = date_format("%Y-%m-%d %h"), date_breaks = "1 day", date_labels = "%m-%d") +
  geom_image(aes(image = 'Bubble3.png'),size = .025)+
  theme(axis.text.x = element_text(angle = 30),
        plot.title = element_text(size = 40, face = "bold"))
  

  