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
# set date column to the required format
library(lubridate)
plotdata$Date <- dmy(plotdata$Date)
# set Global active power to numeric
plotdata$Global_active_power <- as.numeric(plotdata$Global_active_power)
# create a Datetime column
datetime <- paste(plotdata$Date, plotdata$Time)
plotdata$datetime <- as.POSIXct(datetime)
# create a file
png("plot2.png")
#plot the file
plot(plotdata$datetime,plotdata$Global_active_power,type="l",xlab = " ", ylab="Global Active Power(kilowatts)")
#close the device
dev.off()
