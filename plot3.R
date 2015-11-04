#### Exploratory Data Analysis: Course Project 1 - 11/2015 - MeM

## Clean environment
rm(list=ls())

## Packages
-

## Set working directory
setwd("C:/Users/melmarini/Documents/4. Learning/Coursera/4. Exploratory Data Analysis/Course Project 1/Data")

###################################################################
####################### Data preparation ##########################
###################################################################

## Check if zip file with raw data exists, if not, download zip file
zipfile <- "exdata_data_household_power_consumption.zip"
if(!file.exists(zipfile))
{
  fileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,destfile = zipfile)
} else
{
  "Zip file already exists"
}

## Unzip file to working directory (if the unzipped files exist, do NOT overwrite)
suppressWarnings(unzip(zipfile,overwrite=FALSE))
rm(zipfile)

## Import data
data<-read.csv(file="household_power_consumption.txt",sep=";",na.strings="?")

## Subset data between 2007-02-01 & 2007-02-02
data<-subset(data,data$Date %in% c("1/2/2007","2/2/2007"))

## Paste Date + Time variables and change to date/time class
data$datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

###################################################################
######################## Data plotting ############################
###################################################################

## Plot 3: Line plot with more than 1 variable
png("plot3.png", width=480, height=480) #open device .PNG

plot(data$datetime,data$Sub_metering_1,ann=FALSE,type="n") #set canvas
lines(data$datetime,data$Sub_metering_1,lwd=2,col="black") #plot variable 1
lines(data$datetime,data$Sub_metering_2,lwd=2,col="red") #plot variable 2
lines(data$datetime,data$Sub_metering_3,lwd=2,col="blue") #plot variable 3
title("",xlab="",ylab="Energy sub metering") #set title + y-label
legend("topright", #location of the legend
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), #puts text in the legend
       lty=1, #appropriate symbols lines
       lwd=2.5, #appropriate width of lines
       col=c("black", "red", "blue")) #color of variables

dev.off() #close device