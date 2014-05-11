setwd("C:\\Users\\David\\Documents\\Coursera\\Exploratory Data Analysis\\Assignment 1")

data <- read.table("household_power_consumption.txt", header = TRUE, sep  = ";")  #reads the file into a table

#subsets the file according to the dates we want
data_sub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")    

#transforms the factor column into a vector
data_sub$Global_active_power <- as.numeric(data_sub$Global_active_power)   

#Next few lines optimize the date and time columns
#posix will be the column that includes the hour of the day AND the time of the week
data_sub <- (within(data_sub, posix <- paste(Date, Time, sep = ' ')))
data_sub$posix <- strptime (data_sub$posix, format="%d/%m/%Y %H:%M:%S")

#need to set column as POSIXct instead of POSIXlt because POSIXlt isn't plottable
data_sub$posix <- as.POSIXct(data_sub$posix)


#plots the Global Active Power as a function of the weekdays
#weekdays were automatically set in Portuguese
plot(data_sub$Global_active_power ~data_sub$posix, type = "l", 
     xlab = "", ylab = "Global Active Power", yaxt ="n")

#sets the y axis on a scale of 0 to 6
axis(2, at = c(0, 1000, 2000, 3000), labels = c(0, 2, 4, 6))


