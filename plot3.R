# plot3.R
#
# This script will check if the zip file has been downloaded/extracted already and if not it will download and extract the file. 
# Once extracted the file is read into a data frame, converted "?"s to NAs and is subsetted to only include data corresponding
# to 1st to 2nd February 2007.
# Subsequently a datetime column is added to combine the date and time fields into a calendar time format.
# The plot is then generated using the png device.



## Define the download and filename parameters

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "exdata_data_household_power_consumption.zip"  
datafile <- "household_power_consumption.txt"


## Download the data and unzip if not already in the current working directory:

if ( !file.exists(zipfile) )
{
        download.file(url, zipfile)
}


if ( !file.exists(datafile) )
{
        unzip(zipfile, datafile)
}

# Read data into a data frame and subset to just the dates required:

data <- subset(read.table(datafile, header = TRUE, sep = ";", na.strings = "?"), Date == "1/2/2007" | Date == "2/2/2007")

## Process the date and times columns to add an extra column, datetime, with the POSIXct class:

datetime <- data.frame( datetime = strptime(paste0(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S") )
data <- cbind(datetime, data )
rm(datetime)

## Generate the plot:

### Open the png graphic device:

png("plot3.png", width = 480, height = 480, units = "px")


#### Generate plot:
with(data, plot(datetime , Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering") )
with(data, lines(datetime, Sub_metering_1, type = "l", col = "black") )
with(data, lines(datetime, Sub_metering_2, type = "l", col = "red") )
with(data, lines(datetime, Sub_metering_3, type = "l", col = "blue") )
legend("topright", legend = names(data)[grep("Sub.*", names(data))], col = c("black", "red", "blue"), lty = 1)

dev.off()