Sys.setlocale("LC_TIME", "English")

#1. Download the data.

hpcData <- read.table("household_power_consumption.txt", header= TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#2. Selected data for the days of interest

hpcSubsetData <- hpcData[hpcData$Date %in% c("1/2/2007","2/2/2007"),]

#3. Prepare png and set layout
png(filename= 'plot4.png', width = 480, height= 480)
par(mfrow = c(2, 2)) 

#4. Convert Data
hpcSubsetData$Date = as.Date(hpcSubsetData$Date, format="%d/%m/%Y")
globalActivePower <- as.numeric(hpcSubsetData$Global_active_power)
globalReactivePower <-  as.numeric(hpcSubsetData$Global_reactive_power)
voltage <-  as.numeric(hpcSubsetData$Voltage)
datetime <- as.POSIXct(paste(hpcSubsetData$Date, as.factor(hpcSubsetData$Time)))
subMetering1 <- as.numeric(hpcSubsetData$Sub_metering_1)
subMetering2 <- as.numeric(hpcSubsetData$Sub_metering_2)
subMetering3 <- as.numeric(hpcSubsetData$Sub_metering_3)

# Get xaxis
start_datetime <- datetime[1]
next_datetime_lst <- list()
next_weekday_lst <- list()
for (i in 0:2) {
  next_datetime <- start_datetime + lubridate::days(i)
  next_weekday <- weekdays(next_datetime, abbreviate = TRUE)  
  next_weekday_lst <- c(next_weekday_lst, list(next_weekday))
  next_datetime_lst <- c(next_datetime_lst, list(next_datetime))
}

#First Plot

plot(datetime, globalActivePower,  xaxt = "n", type="l", xlab="", ylab="Global Active Power", cex=0.2)
axis(side=1, at = c(next_datetime_lst[1], next_datetime_lst[2], next_datetime_lst[3]),
     labels = c(next_weekday_lst[1], next_weekday_lst[2], next_weekday_lst[3]))

# Second plot
plot(datetime, voltage, xaxt = "n", type="l", xlab="datetime", ylab="Voltage")
axis(side=1, at = c(next_datetime_lst[1], next_datetime_lst[2], next_datetime_lst[3]),
     labels = c(next_weekday_lst[1], next_weekday_lst[2], next_weekday_lst[3]))

# Third plot
plot(datetime, subMetering1, xaxt = "n", type="l", ylab="Energy sub metering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
axis(side=1, at = c(next_datetime_lst[1], next_datetime_lst[2], next_datetime_lst[3]),
     labels = c(next_weekday_lst[1], next_weekday_lst[2], next_weekday_lst[3]))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

# Fourth plot
plot(datetime, globalReactivePower, xaxt = "n", type="l", xlab="datetime", ylab="Global_reactive_power", cex=0.2)
axis(side=1, at = c(next_datetime_lst[1], next_datetime_lst[2], next_datetime_lst[3]),
     labels = c(next_weekday_lst[1], next_weekday_lst[2], next_weekday_lst[3]))

dev.off()