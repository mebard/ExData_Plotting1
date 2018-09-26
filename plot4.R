library(lubridate, lib.loc = "C:/Library/R")

#Read in data from working directory
household_power_consumption <- read.csv("./household_power_consumption.txt", sep=";", 
                                        stringsAsFactors = FALSE)

#convert vars to numeric
household_power_consumption$Global_active_power <- as.numeric(household_power_consumption$Global_active_power)
household_power_consumption$Sub_metering_1 <- as.numeric(household_power_consumption$Sub_metering_1)
household_power_consumption$Sub_metering_2 <- as.numeric(household_power_consumption$Sub_metering_2)
household_power_consumption$Sub_metering_3 <- as.numeric(household_power_consumption$Sub_metering_3)
household_power_consumption$Voltage <- as.numeric(household_power_consumption$Voltage)
household_power_consumption$Global_reactive_power <- as.numeric(household_power_consumption$Global_reactive_power)

#convert date from char to date
household_power_consumption$datetime <- strptime(paste(household_power_consumption$Date, household_power_consumption$Time,
                                                       sep=" "), "%d/%m/%Y %H:%M:%S") 
household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")

#select data from data from 2007-02-01 and 2007-02-02
household_power_consumption_sml <- subset(household_power_consumption, Date %in% as.Date(c("2007-02-01", "2007-02-02")))

#create plot4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
#top right
with(household_power_consumption_sml, plot(datetime, Global_active_power, type="l", 
                                           xlab = "", ylab = "Global Active Power"))
#top left
with(household_power_consumption_sml, plot(datetime, Voltage, type="l", xlab = "datetime", ylab = "Voltage"))
#bottom right
with(household_power_consumption_sml, plot(datetime, Sub_metering_1, type="l", 
                                           col = "black", xlab = "", ylab = "Energy sub metering"))
lines(household_power_consumption_sml$datetime, household_power_consumption_sml$Sub_metering_2, type="l", col = "red")
lines(household_power_consumption_sml$datetime, household_power_consumption_sml$Sub_metering_3, type="l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), 
       lty=1, bty='n' )
#bottom left
with(household_power_consumption_sml, plot(datetime, Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()


