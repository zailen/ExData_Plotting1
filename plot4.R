## Loading file into R

library(dplyr)
library(data.table) 

hh_data <- tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep= ";", na.strings = c("?","")))
hh_data$Date <- as.Date(hh_data$Date, format = "%d/%m/%Y")

hh_subset <- filter(hh_data, Date == "2007-02-01" | Date == "2007-02-02")

hh_subset$timetemp <- paste(hh_subset$Date, hh_subset$Time)
hh_subset$Time <- strptime(hh_subset$timetemp, format = "%Y-%m-%d %H:%M:%S") 

png('plot4.png', width=480, height=480)

par(mfrow = c(2, 2))

# plot 1,1
plot(hh_subset$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xaxt='n')
axis(1, at=c(0, 1441, 2881), labels=c("Thu", "Fri", "Sat"))

#plot 1,2
plot(hh_subset$Voltage, type="l", ylab="Voltage", xaxt='n')
axis(1, at=c(0, 1441, 2881), labels=c("Thu", "Fri", "Sat"), xlab="datetime")

# plot 2,1
plot(hh_subset$Sub_metering_1, type="l", ylab="Energy sub metering", xaxt='n')
points(hh_subset$Sub_metering_2, col="red", type="l")
points(hh_subset$Sub_metering_3, col="blue", type="l")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)

# plot 2,2
plot(hh_subset$Global_reactive_power, ylab="Global_reactive_power", type="l", xaxt='n')
axis(1, at=c(0, 1441, 2881), labels=c("Thu", "Fri", "Sat"), xlab="datetime")

dev.off()
