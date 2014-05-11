setwd("C:\\Users\\David\\Documents\\Coursera\\Exploratory Data Analysis\\Assignment 1")

data <- read.table("household_power_consumption.txt", header = TRUE, sep  = ";")  #reads the file into a table

data_sub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")    #subsets the file according to the dates we want

#transforms the factor column into a vector
data_sub$Global_active_power <- as.numeric(data_sub$Global_active_power)   

#Next couple of lines optimize the date and time columns
#posix will be the column that includes the hour of the day AND the time of the week
data_sub <- (within(data_sub, posix <- paste(Date, Time, sep = ' ')))
data_sub$posix <- strptime (data_sub$posix, format="%d/%m/%Y %H:%M:%S")

#need to set column as POSIXct instead of POSIXlt because POSIXlt isn't plottable
data_sub$posix <- as.POSIXct(data_sub$posix)

#Before plotting sub-metering we need to set them as numeric vectors instead of factors
data_sub$Sub_metering_1 <- as.numeric(data_sub$Sub_metering_1)
data_sub$Sub_metering_2 <- as.numeric(data_sub$Sub_metering_2)
data_sub$Sub_metering_3 <- as.numeric(data_sub$Sub_metering_3)

#Plots sub metering 1 as a function of time

plot(data_sub$Sub_metering_1 ~ data_sub$posix, type = "l", yaxt = "n", ylab = "Energy sub metering",
     xlab = "", ylim = c(0, 35))
axis(2, at = c(0,10,20,30))

#Adds Sub_metering_2 as a red line and Sub_metering_3 as a blue line
lines(data_sub$Sub_metering_2 ~ data_sub$posix, col = "red")
lines(data_sub$Sub_metering_3 ~ data_sub$posix, col = "blue")

#Next code lines add the graph legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))


