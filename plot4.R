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
png("plot4.png")
# create space for 4 graphs
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
# Create graph 1
plot(plotdata$datetime,plotdata$Global_active_power,type="l",xlab = " ", ylab="Global Active Power(kilowatts)")
# Create graph 2
# Make Voltage as numeric
plotdata$Voltage <- as.numeric(plotdata$Voltage)
plot(plotdata$datetime,plotdata$Voltage,type="l",xlab = "datetime", ylab="Voltage")
# Create graph 3
plot(plotdata$datetime,plotdata$Sub_metering_1,xlab = "",ylab="Energy sub metering",type="n")
points(plotdata$datetime,plotdata$Sub_metering_1,type="l",col="Black")
points(plotdata$datetime,plotdata$Sub_metering_2,type="l",col="Red")
points(plotdata$datetime,plotdata$Sub_metering_3,type="l",col="Blue")
legend("topright",col=c("black","blue","red"),lty=1,lwd=2,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# Create plot 4
plotdata$Global_reactive_power<- as.numeric(plotdata$Global_reactive_power)
plot(plotdata$datetime,plotdata$Global_reactive_power,xlab="datetime",ylab = "Global_reactive_power",type="l")
#close device
dev.off()