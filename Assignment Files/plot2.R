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
png(filename = "./exploring/plot2.png")

## plot 2 - line graph - global active power across time - days labeled on x-axis
plot(dat2$DT ,dat2$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab ="")

## Close connection
dev.off()