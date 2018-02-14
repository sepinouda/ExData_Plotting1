######################## Load data ########################
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

######################## Changing the date to Date type ########################
data$Date <- as.Date(data$Date, "%d/%m/%Y")

######################## Subset the data to include the range of dates from Feb. 1, 2007 to Feb. 2, 2007 ########################
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

######################## Keep only the complete cases ########################
data <- data[complete.cases(data),]

######################## Use one column to represent date and time simultaneously ########################
DT <- paste(data$Date, data$Time)
DT <- setNames(DT, "Date and Time")

######################## Update the dataset accordingly ########################
data <- data[ ,!(names(data) %in% c("Date","Time"))]
data <- cbind(DT, data)
data$DT <- as.POSIXct(DT)

######################## Creating and saving the first plot ########################
hist(data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
