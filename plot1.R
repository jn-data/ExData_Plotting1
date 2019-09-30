# plot1.R
#
# This script will check if the zip file has been downloaded/extracted already and if not it will download and extract the file. 
# Once extracted the file is read into a data frame, converted "?"s to NAs and is subsetted to only include data corresponding
# to 1st to 2nd February 2007.
# The histogram plot is then generated using the png device.


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


## Generate the plots:

### Open the png graphic device:

png("plot1.png", width = 480, height = 480, units = "px")

hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", breaks = 12)

dev.off()