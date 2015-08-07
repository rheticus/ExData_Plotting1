
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
png("plot1.png", width = 480, height = 480)

# Plot 1 is a simple histogram
hist(subdat$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")

# close the graphics device to output the PNG file
dev.off()

