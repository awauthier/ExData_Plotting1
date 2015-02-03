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
data$Global_active_power <- as.numeric(data$Global_active_power)/1000
data$DateTime <- ymd_hms(paste(format(data$Date, "%Y%m%d"), as.character(data$Time)))

# Construct the graph
library(graphics)
Sys.setlocale("LC_TIME", "English")
plot(data$DateTime, 
	 data$Global_active_power, 
	 type="l",
	 xlab="",
	 ylab="Global Active Power (kilowatts)")

# Create the corresponding png file
dev.copy(png, file="plot2.png")
dev.off()
