## Load library for conditional data loading
library(sqldf)

## Load the data corresponding to specific dates
energyDF<-read.csv.sql("./household_power_consumption.txt",sql="select * from file where [Date] IN ('1/2/2007', '2/2/2007')", header=TRUE, sep=";")

## Convert to date
energyDF$Date<-as.Date(energyDF$Date, format="%d/%m/%Y")
## Convert to time
energyDF$Time<-strptime(energyDF$Time, "%H:%M:%S")
year(energyDF$Time)<-year(energyDF$Date)
month(energyDF$Time)<-month(energyDF$Date)
day(energyDF$Time)<-day(energyDF$Date)

## Second plot is a line chart with 1 series of Global_Active_power over time
png(filename = "Plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white",  res = NA)
par(mfcol=c(1,1))
with(energyDF, plot(Time,Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()
