## Downloading file, just for plot 1

if (!file.exists('data')){
    dir.create('data')
}

fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

download.file(fileURL, destfile = './data/exdata_data_household_power_consumption.zip', method = 'curl')

dateDownloaded <- date()
dateDownloaded

## Loading file into R

unz('./data/exdata_data_household_power_consumption.zip', './data/household_power_consumption.txt')

library(dplyr)
library(data.table) 

hh_data <- tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep= ";", na.strings = c("?","")))
hh_data$Date <- as.Date(hh_data$Date, format = "%d/%m/%Y")

hh_subset <- filter(hh_data, Date == "2007-02-01" | Date == "2007-02-02")

hh_subset$timetemp <- paste(hh_subset$Date, hh_subset$Time)
hh_subset$Time <- strptime(hh_subset$timetemp, format = "%Y-%m-%d %H:%M:%S") 

# just a test
test <- hh_subset[1:10,]
sapply(test, class)


# Explicitly adding width and height parameters even if they are equal to default

png("plot1.png", width = 480, height = 480) 

hist(hh_subset$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()



