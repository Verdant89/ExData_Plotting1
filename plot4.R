setwd("C:\\Users\\David\\Documents\\Coursera\\Exploratory Data Analysis\\Assignment 1")

data <- read.table("household_power_consumption.txt", header = TRUE, sep  = ";")  #reads the file into a table

data_sub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")    #subsets the file according to the dates we want

#transforms the factor columns into a vectors so we can plot them properly
data_sub$Global_active_power <- as.numeric(data_sub$Global_active_power)   
data_sub$Voltage <- as.numeric(data_sub$Voltage)
data_sub$Global_reactive_power <- as.numeric(data_sub$Global_reactive_power) 


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


#This sets 4 plots in the same figure in 2 rows and 2 columns and
#adjusts the margins
par(mfrow = c(2,2), mar = c(4,4,3,3))


#Now the plotting begins!

#---------------------------
#Plot 1
#plots the Global Active Power as a function of the weekdays
#weekdays were automatically set in Portuguese
plot(data_sub$Global_active_power ~data_sub$posix, type = "l", 
     xlab = "", ylab = "Global Active Power", yaxt ="n")

#sets the y axis on a scale of 0 to 6
axis(2, at = c(0, 1000, 2000, 3000), labels = c(0, 2, 4, 6))


#---------------------------
#Plot 2
#Plots Voltage as a function of date and time
plot(data_sub$Voltage ~data_sub$posix, type = "l", xlab = "datetime", 
     ylab = "Voltage", yaxt = "n")

#Sets the y axis as requested
axis(2, at = seq(from = 950, to = 2150, length.out = 7), 
     labels = seq(from = 234, to = 246, by = 2) )


#---------------------------
#Plot 3
#Plots sub metering 1 as a function of time

plot(data_sub$Sub_metering_1 ~ data_sub$posix, type = "l", yaxt = "n", ylab = "Energy sub metering",
     xlab = "", ylim = c(0, 35))
axis(2, at = c(0,10,20,30))

#Adds Sub_metering_2 as a red line and Sub_metering_3 as a blue line
lines(data_sub$Sub_metering_2 ~ data_sub$posix, col = "red")
lines(data_sub$Sub_metering_3 ~ data_sub$posix, col = "blue")

#Next code lines add the graph legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"), bty = "n", cex = 0.7)


#---------------------------

#Plot 4
#Plots Global Reactive Power as a function of date and time
plot(data_sub$Global_reactive_power ~ data_sub$posix, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power", yaxt = "n")

axis(2, at = seq(from = 0, to = 225, length.out = 6), 
     label = c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5), cex.axis = 0.8)

