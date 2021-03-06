if (!file.exists("household_power_consumption.txt")) {
	# Download the zip file
	download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip", "household_power_consumption.zip")
	
	# Extract the zip file
	unzip("household_power_consumption.zip")
}

# Load the data
f <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

# Filter the data on the 2 dates we need
library(lubridate)
f$Date <- dmy(f$Date)
data <- f[f$Date %in% dmy(c("01/02/2007","02/02/2007")),]

# Convert numbers and dates
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$DateTime <- ymd_hms(paste(format(data$Date, "%Y%m%d"), as.character(data$Time)))

# Construct the graph
library(graphics)
Sys.setlocale("LC_TIME", "English")
yRange <- range(c(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3))

# Open the png
png("plot3.png")

plot(data$DateTime, 
	 data$Sub_metering_1, 
	 type="l",
	 xlab="",
	 ylab="Energy sub metering",
	 ylim=yRange)

par(new=TRUE)
plot(data$DateTime, 
   	 data$Sub_metering_2, 
	 type="l",
	 axes=TRUE,
	 xlab="",
	 ylab="",
	 col="red",
	 ylim=yRange)

par(new=TRUE)
plot(data$DateTime, 
	 data$Sub_metering_3, 
	 type="l",
	 axes=FALSE,
	 xlab="",
	 ylab="",
	 col="blue",
	 ylim=yRange)

legend("topright", 
	   legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
	   lty=1, 
	   col=c("black", "red", "blue"),
	   lwd=1,
	   cex=1)

# Close the png
dev.off()
