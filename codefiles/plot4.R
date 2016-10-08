## Load in the required libraries
library(dplyr)
library(data.table)


## download the data file if it is not there
if (!file.exists("./household_power_consumption.txt")) {
  ## download the zip file and unzip the files.
  fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  print("Downloading the zip file...")
  download.file(fileurl,destfile="./household_power_consumption.zip")
  print("Unzipping the downloaded file...")
  unzip("./household_power_consumption.zip",overwrite = TRUE)
}

#Reads in data from file then subsets data for specified dates
dpower <- read.csv2("household_power_consumption.txt", na.strings="?", ,stringsAsFactors = FALSE)
## Get the data for only the 1'st and 2nd Feb 2007
ddayspower <- filter(dpower, Date == "1/2/2007" | Date == "2/2/2007")

rm(dpower)

## Add a new column to this dataset combining the dte and the time values
ddayspower$Date_time <- strptime(paste(ddayspower$Date, ddayspower$Time), "%d/%m/%Y %H:%M:%S")

## convert the numerical data columns to numeric
ddayspower$Global_active_power <- as.numeric(as.character(ddayspower$Global_active_power))
ddayspower$Global_reactive_power <- as.numeric(as.character(ddayspower$Global_reactive_power))
ddayspower$Voltage <- as.numeric(as.character(ddayspower$Voltage))
ddayspower$Global_intensity <- as.numeric(as.character(ddayspower$Global_intensity))
ddayspower$Sub_metering_1 <- as.numeric(as.character(ddayspower$Sub_metering_1))
ddayspower$Sub_metering_2 <- as.numeric(as.character(ddayspower$Sub_metering_2))
ddayspower$Sub_metering_3 <- as.numeric(as.character(ddayspower$Sub_metering_3))

## for plot 4
## First set up the canvas for 4 graphs 
par(mfcol = c(2,2))

# plot 4.1 in c(1,1)
plot(ddayspower$Date_time, ddayspower$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")


# plot 2 in c(2,1) in essence we are repeating commands for plot 3 here
plot(ddayspower$Date_time, ddayspower$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(ddayspower$Date_time, ddayspower$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red")
points(ddayspower$Date_time, ddayspower$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot 3 in c(1,2)
plot(ddayspower$Date_time, ddayspower$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")


# plot 4 in c(2,2)
plot(ddayspower$Date_time, ddayspower$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

## write to the plot4.png
dev.copy(png,"plot4.png")
dev.off()
rm(ddayspower)