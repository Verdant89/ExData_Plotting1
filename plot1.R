setwd("C:\\Users\\David\\Documents\\Coursera\\Exploratory Data Analysis\\Assignment 1")

#reads the file into a table
data <- read.table("household_power_consumption.txt", header = TRUE, sep  = ";")  

#subsets the file according to the dates we want
data_sub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")    

#column needs to be a numeric vector so we can plot it properly
data_sub$Global_active_power <- as.numeric(data_sub$Global_active_power) 


#plots histogram of Global Active Power
with(data_sub, hist(Global_active_power, xlab = "Global Active Power (killowatts)", 
                    main = "Global Active Power", col = "orangered2", 
                    xaxt = "n", breaks = seq(0, 3750, by = 250)))    

#Sets the x axis as requested
axis(1, at = c(0, 1000, 2000, 3000), labels = c(0, 2, 4, 6))
