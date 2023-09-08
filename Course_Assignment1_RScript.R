#load library
library(dplyr)

#data was downloaded and saved to the working library to be read in. 
#Load the Data
data <- read.table('household_power_consumption.txt', header = TRUE, sep = ";")
#convert date from character string to date
data$Date <- as.Date(data$Date, format= "%d/%m/%Y")
data$Global_active_power<-as.numeric(data$Global_active_power)
#Subset data to only be February 1st and 2nd of 2007. 
data2 <-subset(data, Date>="2007-02-01" & Date<="2007-02-02")
#merge date and time into one variable
data2 <- mutate(data2, Date_Time = paste(Date, Time, sep = " "))
data2$Date_Time<-strptime(data2$Date_Time, format="%Y-%m-%d %H:%M:%S")

#plot 1
png("Plot_1.png")
hist(data2$Global_active_power, xlab = "Global Active Power (kilowatts)", col="red", main = "Global Active Power")
dev.off()

#plot 2 
png("Plot_2.png")
plot(x=data2$Date_Time, y=data2$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab="", type = "l")
dev.off()

#plot 3 
png("Plot_3.png")
plot(x=data2$Date_Time, y=data2$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab="")
points(data2$Date_Time, data2$Sub_metering_1, col="black", type = "l")
points(data2$Date_Time, data2$Sub_metering_2, col="red", type = "l")
points(data2$Date_Time, data2$Sub_metering_3, col="blue", type = "l")
legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

#plot 4 
png("Plot_4.png")
par(mfrow=c(2,2))
plot(x=data2$Date_Time, y=data2$Global_active_power, ylab = "Global Active Power", xlab="", type = "l")
plot(x=data2$Date_Time, y=data2$Voltage, ylab = "Voltage", xlab="datetime", type = "l")
plot(x=data2$Date_Time, y=data2$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab="")
points(data2$Date_Time, y=data2$Sub_metering_1, col="black", type = "l")
points(data2$Date_Time, y=data2$Sub_metering_2, col="red", type = "l")
points(data2$Date_Time, y=data2$Sub_metering_3, col="blue", type = "l")
legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(x=data2$Date_Time, y=data2$Global_reactive_power, type = "l", ylab="Global_reactive_power", xlab="datetime")
dev.off()