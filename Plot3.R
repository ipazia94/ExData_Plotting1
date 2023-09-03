Sys.setlocale("LC_TIME", "English")

#1. Download the data.

hpcData <- read.table("household_power_consumption.txt", header= TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#2. Selected data for the days of interest

hpcSubsetData <- hpcData[hpcData$Date %in% c("1/2/2007","2/2/2007"),]

#3. Convert Data
hpcSubsetData$Date = as.Date(hpcSubsetData$Date, format="%d/%m/%Y")
subMetering1 <- as.numeric(hpcSubsetData$Sub_metering_1)
subMetering2 <- as.numeric(hpcSubsetData$Sub_metering_2)
subMetering3 <- as.numeric(hpcSubsetData$Sub_metering_3)
datetime <- as.POSIXct(paste(hpcSubsetData$Date, as.factor(hpcSubsetData$Time)))

#4. Prepare png
png(filename= 'plot3.png', width = 480, height= 480)

#5. Get xaxis
start_datetime <- datetime[1]
next_datetime_lst <- list()
next_weekday_lst <- list()
for (i in 0:2) {
  next_datetime <- start_datetime + lubridate::days(i)
  next_weekday <- weekdays(next_datetime, abbreviate = TRUE)  
  next_weekday_lst <- c(next_weekday_lst, list(next_weekday))
  next_datetime_lst <- c(next_datetime_lst, list(next_datetime))
}

#6. Plot graph and add xaxis and legend
plot(datetime, subMetering1, type="l", xaxt = "n", ylab="Energy sub metering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")

axis(side=1, at = c(next_datetime_lst[1], next_datetime_lst[2], next_datetime_lst[3]),
     labels = c(next_weekday_lst[1], next_weekday_lst[2], next_weekday_lst[3]))

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.off()