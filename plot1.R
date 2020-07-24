# Get the file link
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# Download the file
download.file(fileURL,destfile="./plotfile.zip")
# unzip the file
unzip("./plotfile.zip")
# read the file
data<-read.csv("./household_power_consumption.txt",sep=";")
# subset for 1st Feb and 2nd Feb 2007
plotdata <- data[data$Date=="1/2/2007"|data$Date=="2/2/2007",]
# set Date column to the required date format
library(lubridate)
plotdata$Date <- dmy(plotdata$Date)
# make Global active power as numeric so as to plot hist()
plotdata$Global_active_power <- as.numeric(plotdata$Global_active_power)
# Set file
png("plot1.png")
#plot the hist
hist(plotdata$Global_active_power,main = "Global Active Power", xlab = "Global Active Power(kilowatts)",col="red")
# close the device
dev.off()
