# Check if the uncompressed data file already exists
# Download and decompress it if not
if (!file.exists("household_power_consumption.txt")) {
	download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip", "household_power_consumption.zip")
	unzip("household_power_consumption.zip")
}

# Load the data
f <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

# Filter the data on the 2 dates we need
library(lubridate)
f$Date <- dmy(f$Date)
data <- f[f$Date %in% dmy(c("01/02/2007","02/02/2007")),]

# Convert numbers
data$Global_active_power <- as.numeric(data$Global_active_power)/1000

# Construct the graph
library(graphics)
hist(data$Global_active_power, 
	 main="Global Active Power",
	 xlab="Global Active Power (kilowatts)",
	 ylab="Frequency",
	 col="red")

# Create the corresponding png file
dev.copy(png, file="plot1.png")
dev.off()

