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
png(filename = "./exploring/plot4.png")

## plot 4 - 
par(mfrow=c(2,2),mfcol=c(2,2)) ## ajusting col/rows
# 1st plot 
plot(dat2$DT ,dat2$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab ="")
#2nd plot 
plot(dat2$DT, dat2$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="", sub="")
points(dat2$DT, dat2$Sub_metering_2, col="red", type = "l")
points(dat2$DT, dat2$Sub_metering_3, col="blue", type = "l")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col = c("black", "red", "blue"), bty = "n", pt.lwd = 0)
## 3rd and 4th plots
plot(dat2$DT, dat2$Voltage, type = "l", xlab="DateTime", ylab = "Voltage")
plot(dat2$DT, dat2$Global_reactive_power, type = "l", xlab="DateTime", ylab = "Global Reactive Power")

## Close connection
dev.off()