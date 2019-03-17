# Load libraries:
library(data.table)

# Download the data:
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileZip <- "Electric_Power_Consumption.zip"
fileData <- "household_power_consumption.txt"

if (!file.exists(fileZip)) {
    download.file(fileUrl, destfile=fileZip)
    unzip(fileZip)
}

# Read the data, and subsetting:
data <- fread(file=fileData, na.strings="?")
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

# Create dateTime variable, coerse Date.
data$dateTime <- as.POSIXct(strptime(paste(data$Date," ",data$Time), "%d/%m/%Y %H:%M:%S"))
data$Date <- as.Date(data$Date,"%d/%m/%Y")

##########################################################################
#Create plots:
Sys.setlocale(category = "LC_TIME", locale = "English_United States.1252")
png("plot4.png")

par(mfcol=c(2,2))

# Plot topleft:
plot(x=data$dateTime, y=data$Global_active_power, xlab="",ylab="Global Active Power (kilowatts)", type="n")
lines(x=data$dateTime, y=data$Global_active_power)

# Plot bottomleft:
plot(x=data$dateTime, y=data$Sub_metering_1, xlab="",ylab="Energy sub metering", type="n")
lines(x=data$dateTime, y=data$Sub_metering_1, col="black")
lines(x=data$dateTime, y=data$Sub_metering_2, col="red")
lines(x=data$dateTime, y=data$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), bty="n",lty=c(1,1,1),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Plot topright:
plot(x=data$dateTime, y=data$Voltage, xlab="dateTime",ylab="Voltage", type="n")
lines(x=data$dateTime, y=data$Voltage)

# Plot bottomright:
plot(x=data$dateTime, y=data$Global_reactive_power, xlab="dateTime",ylab="Global_reactive_power", type="n")
lines(x=data$dateTime, y=data$Global_reactive_power)

dev.off()