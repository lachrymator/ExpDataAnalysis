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

## Converting date variables into date format, subsetting by desired dates


data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
Date1 <- as.Date("2007-02-01", format = "%Y-%m-%d")
Date2 <- as.Date("2007-02-02", format = "%Y-%m-%d")
data<-subset(data, (data$Date == Date1) | (data$Date == Date2))

## Combining date and time for one continuous time representation over the two days

x<-strptime(as.vector(paste(data$Date, data$Time)), format = "%Y-%m-%d %H:%M:%S", tz="")

## Generating the plot for plot2.png

y<-data$Global_active_power

png(file = "plot2.png", bg = "white")
plot(x,y, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
message("Done! Plot stored as plot2.png")
dev.off()
