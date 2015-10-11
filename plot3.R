## Loading file into R

library(dplyr)
library(data.table) 

hh_data <- tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep= ";", na.strings = c("?","")))
hh_data$Date <- as.Date(hh_data$Date, format = "%d/%m/%Y")

hh_subset <- filter(hh_data, Date == "2007-02-01" | Date == "2007-02-02")

hh_subset$timetemp <- paste(hh_subset$Date, hh_subset$Time)
hh_subset$Time <- strptime(hh_subset$timetemp, format = "%Y-%m-%d %H:%M:%S") 

png('plot3.png', width=480, height=480)

plot(hh_subset$Sub_metering_1, type="l", ylab="Energy sub metering", xaxt='n')
points(hh_subset$Sub_metering_2, col="red", type="l")
points(hh_subset$Sub_metering_3, col="blue", type="l")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)

dev.off()
