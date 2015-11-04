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

## Plot 1: Histogram
png("plot1.png", width=480, height=480) #open device .PNG
hist(data$Global_active_power, #data to be plotted
     main="Global active power", #plot title
     xlab="Global Active Power (kilowatts)", #label on x-axis
     col="red") #bar color

dev.off() #close device
