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
# create device
png("plot3.png")
# make blank plot
plot(plotdata$datetime,plotdata$Sub_metering_1,xlab = "",ylab="Energy sub metering",type="n")
# make first plot
points(plotdata$datetime,plotdata$Sub_metering_1,type="l",col="Black")
# make second plot
points(plotdata$datetime,plotdata$Sub_metering_2,type="l",col="Red")
# make third plot
points(plotdata$datetime,plotdata$Sub_metering_3,type="l",col="Blue")
# make legend
legend("topright",col=c("black","blue","red"),lty=1,lwd=2,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# close device
dev.off()