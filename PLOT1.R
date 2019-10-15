table <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", 
                    colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
table$Date <- as.Date(table$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
table <- subset(table,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
table <- table[complete.cases(table),]

## Combine Date and Time column
dateTime <- paste(table$Date, table$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
table <- table[ ,!(names(table) %in% c("Date","Time"))]

## Add DateTime column
table <- cbind(dateTime, table)

## Format dateTime Column
table$dateTime <- as.POSIXct(dateTime)

##Plot 1 

## Create the histogram
PLOT1 <- hist(table$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

dev.copy(png, file='PLOT1.png', height=480, width=480)
dev.off()