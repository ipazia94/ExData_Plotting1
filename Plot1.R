#1. Download the data.

hpcData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = F)

#2. Selected data for the days of interest

hpcSubsetData <- hpcData[hpcData$Date %in% c("1/2/2007","2/2/2007"),]

#3. Convert Data
hpcSubsetData$Date <- as.Date(hpcSubsetData$Date, format="%d/%m/%Y")
hpcSubsetData$Global_active_power = as.numeric(hpcSubsetData$Global_active_power)

#5 prepare PNG
png(filename= 'plot1.png', width = 480, height= 480)
par(las=1)

#6 Plot histogram

hist(hpcSubsetData$Global_active_power, xlab= 'Global Active Power (kilowatts)', ylab= 'Frequency', main = 'Global Active Power', col= 'red' )

dev.off()





