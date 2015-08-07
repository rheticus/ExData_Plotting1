
# load the packages 'dplyr' and 'readr', which are used to read and manipulate the incoming data
# the readr pkg provides versions of read.csv, etc. which are much faster than the default versions
pkgs = c("dplyr", "readr")

# safe package installation - avoids attempting to install package if already present
for (i in pkgs) {
    if (!require(i, character.only = TRUE)) install.packages(i)
    library(i, character.only = TRUE)
}

# read in data and filter it to contain just 2 specific days
fulldat <- read_csv2("household_power_consumption.txt", na = '?')
subdat <- filter(fulldat, fulldat$Date == "1/2/2007" | fulldat$Date == "2/2/2007")

# add new var 'datetime' to hold both date and time as POSIX date class
subdat <- mutate(subdat, datetime = as.POSIXct(strptime(paste(subdat$Date, subdat$Time), "%d/%m/%Y %H:%M:%S")))


# create the plot using the PNG graphics device
png("plot3.png", width = 480, height = 480)

# Plot 3 is a line plot with 3 variables
with(subdat, plot(datetime, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l"))
with(subdat, points(datetime, Sub_metering_2, "l", col = "red"))
with(subdat, points(datetime, Sub_metering_3, "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close the graphics device to output the PNG file
dev.off()

