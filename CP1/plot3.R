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

## Converting dates, subsetting to desired days

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
Date1 <- as.Date("2007-02-01", format = "%Y-%m-%d")
Date2 <- as.Date("2007-02-02", format = "%Y-%m-%d")
data<-subset(data, (data$Date == Date1) | (data$Date == Date2))

## Combining date and time for continuous time representation

x<-strptime(as.vector(paste(data$Date, data$Time)), format = "%Y-%m-%d %H:%M:%S", tz="")

## Generating plot3

png(file = "plot3.png", bg = "white")
plot(x,data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(x, data$Sub_metering_2, col = "red")
lines(x, data$Sub_metering_3, col = "blue")
legend("topright", names(data)[7:9], col = c("black", "red", "blue"), lty = c(1,1,1))
dev.off()
message("Done! Plot stored as plot3.png")