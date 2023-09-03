Sys.setlocale("LC_TIME", "English")
#1. Download the data.

hpcData <- read.table("household_power_consumption.txt", header= TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#2. Selected data for the days of interest

hpcSubsetData <- hpcData[hpcData$Date %in% c("1/2/2007","2/2/2007"),]

#3. Convert Data

hpcSubsetData$Date = as.Date(hpcSubsetData$Date, format="%d/%m/%Y")
globalActivePower <- as.numeric(hpcSubsetData$Global_active_power)

#4. DateTime Data

datetime <- as.POSIXct(paste(hpcSubsetData$Date, as.factor(hpcSubsetData$Time)))

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

#6. Prepare png
png(filename= 'plot2.png', width = 480, height= 480)

#7. Plot graph, adding axis
plot(globalActivePower~datetime, type="l", xaxt = "n",xlab="", ylab="Global Active Power (kilowatts)")
axis(side=1, at = c(next_datetime_lst[1], next_datetime_lst[2], next_datetime_lst[3]),
     labels = c(next_weekday_lst[1], next_weekday_lst[2], next_weekday_lst[3]))
dev.off()


