## File Location

fileurl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Download file to a temporary location, read in dataframe, and delete tempfile

temp<-tempfile()
download.file(fileurl, temp)
filename<-unzip(temp, list=TRUE)[[1]]
message("Reading in data frame... please wait.")
data<-read.csv(unzip(temp,filename), header = TRUE, sep = ";", na.strings = c("?"))
unlink(temp)
unlink(filename)

## Convert dates from characters to dates, subset to dates of interest

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
Date1 <- as.Date("2007-02-01", format = "%Y-%m-%d")
Date2 <- as.Date("2007-02-02", format = "%Y-%m-%d")
data<-subset(data, (data$Date == Date1) | (data$Date == Date2))

## Generate the plot for plot1.png

png(file = "plot1.png", bg = "white")
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.off()
message("Done! Plot stored as plot1.png")
