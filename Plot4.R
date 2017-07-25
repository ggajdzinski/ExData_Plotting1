## Load library for conditional data loading
library(sqldf)

energyDF<-read.csv.sql("./household_power_consumption.txt",sql="select * from file where [Date] IN ('1/2/2007', '2/2/2007')", header=TRUE, sep=";")

energyDF$Date<-as.Date(energyDF$Date, format="%d/%m/%Y")

energyDF$Time<-strptime(energyDF$Time, "%H:%M:%S")
year(energyDF$Time)<-year(energyDF$Date)
month(energyDF$Time)<-month(energyDF$Date)
day(energyDF$Time)<-day(energyDF$Date)


png(filename = "Plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white",  res = NA)
par(mfcol=c(2,2))
with(energyDF, plot(Time,Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
with(energyDF, plot(Time, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
lines(energyDF$Time, energyDF$Sub_metering_2, type="l", col="red")
lines(energyDF$Time, energyDF$Sub_metering_3, type="l", col="blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1:1, col=c("black", "red","blue"), cex=0.8, lwd=2, bty="n")
with(energyDF, plot(Time,Voltage, type="l", ylab="Voltage", xlab="datetime"))
with(energyDF, plot(Time,Global_reactive_power, type="l", xlab="datetime"))
dev.off()
