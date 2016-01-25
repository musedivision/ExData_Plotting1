## Reading and cleaning the data
if(!file.exists("exploring")){
      dir.create("exploring")
}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile ="./exploring/powerhouse.zip")
unzip(zipfile = "./exploring/powerhouse.zip", exdir = "./exploring/powerhouse")
dat <- read.table("./exploring/powerhouse/household_power_consumption.txt",
                  colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                  sep = ";", header=TRUE, na.strings = "?")
dat2 <- dat[which(dat$Date == "1/2/2007" | dat$Date == "2/2/2007"),] ## subset between dates needed
dat2$DT <- paste(dat2$Date, dat2$Time, sep = " ") ## combines date aand time then converts to POSIXlt
dat2$DT <- strptime(dat2$DT, "%d/%m/%Y %H:%M:%S") 

## opening PNG graphics device
png(filename = "./exploring/plot3.png")

## plot 3 - 3 sub mertering graphs over time lined with diff col
plot(dat2$DT, dat2$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="", sub="")
## other lines
points(dat2$DT, dat2$Sub_metering_2, col="red", type = "l")
points(dat2$DT, dat2$Sub_metering_3, col="blue", type = "l")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col = c("black", "red", "blue"))

## Close connection
dev.off()