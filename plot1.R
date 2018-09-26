library(lubridate, lib.loc = "C:/Library/R")

#Read in data from working directory
household_power_consumption <- read.csv("./household_power_consumption.txt", sep=";", 
                                      stringsAsFactors = FALSE)

#convert character to numeric
household_power_consumption$Global_active_power <- as.numeric(household_power_consumption$Global_active_power)
household_power_consumption$Sub_metering_1 <- as.numeric(household_power_consumption$Sub_metering_1)
household_power_consumption$Sub_metering_2 <- as.numeric(household_power_consumption$Sub_metering_2)
household_power_consumption$Sub_metering_3 <- as.numeric(household_power_consumption$Sub_metering_3)


#convert date from char to date
household_power_consumption$datetime <- strptime(paste(household_power_consumption$Date, household_power_consumption$Time,
                                                       sep=" "), "%d/%m/%Y %H:%M:%S") 
household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")

#select data from data from 2007-02-01 and 2007-02-02
household_power_consumption_sml <- subset(household_power_consumption, Date %in% as.Date(c("2007-02-01", "2007-02-02")))

#make histogram and save to png
png("plot1.png", width=480, height=480)
hist(household_power_consumption_sml$Global_active_power, main = "Global Active Power", col = "red",
     xlab = "Global Active Power (kilowatts)")
dev.off()