## Loading file into R

library(dplyr)
library(data.table) 

hh_data <- tbl_df(read.table("./data/household_power_consumption.txt", header=TRUE, sep= ";", na.strings = c("?","")))
hh_data$Date <- as.Date(hh_data$Date, format = "%d/%m/%Y")

hh_subset <- filter(hh_data, Date == "2007-02-01" | Date == "2007-02-02")

hh_subset$timetemp <- paste(hh_subset$Date, hh_subset$Time)
hh_subset$Time <- strptime(hh_subset$timetemp, format = "%Y-%m-%d %H:%M:%S") 

table(weekdays(hh_subset$Date))
#Friday Thursday 
#1440     1440 

weekdays(hh_subset$Date)[1440]
# [1] "Thursday"
weekdays(hh_subset$Date)[1441]
# [1] "Friday"

# As data seem to be ordered and there are 1440 Thursday and 1440 Fridays (and no Saturdays)
# I saw the first Friday is the 1441st observation and assume that Saturday would have been the 2881st

png('plot2.png', width=480, height=480)

plot(hh_subset$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xaxt='n')
axis(1, at=c(0, 1441, 2881), labels=c("Thu", "Fri", "Sat"))

dev.off()



