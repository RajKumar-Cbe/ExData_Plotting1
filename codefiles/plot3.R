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



## For plot 3
plot(ddayspower$Date_time, ddayspower$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(ddayspower$Date_time, ddayspower$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red")
points(ddayspower$Date_time, ddayspower$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## write to the plot3.png
dev.copy(png,"plot3.png")
dev.off()

rm(ddayspower)