library(data.table)

# Read the file into a data table, filter out everything but 2007-02-01 and 2007-02-02
all_data <- fread("household_power_consumption.txt", na.strings = "?")[Date=="1/2/2007" | Date=="2/2/2007",]

# Convert Date and Time to a single Date column with proper POSIX datetime format
all_data[,`:=`(Date=as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")), Time=NULL)]

# Plot and save
png("plot1.png", width=480, height=480)
hist(all_data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()