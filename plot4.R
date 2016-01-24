library(data.table)

# Read the file into a data table, filter out everything but 2007-02-01 and 2007-02-02
all_data <- fread("household_power_consumption.txt", na.strings = "?")[Date=="1/2/2007" | Date=="2/2/2007",]

# Convert Date and Time to a single Date column with proper POSIX datetime format
all_data[,`:=`(Date=as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")), Time=NULL)]

# Set up plot
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# Global active power line graph
plot(all_data$Date, all_data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Voltage
plot(all_data$Date, all_data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Sub metering
plot(all_data$Date, all_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(all_data$Date, all_data$Sub_metering_2, type="l", col="red")
lines(all_data$Date, all_data$Sub_metering_3, type="l", col="blue")
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), col=c("black","red","blue"),
       bty="n")

# Global reactive power
plot(all_data$Date, all_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# Save plot
dev.off()