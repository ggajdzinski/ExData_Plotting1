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


## First plot is a histogram of Global_active_power
png(filename = "Plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white",  res = NA)
par(mfcol=c(1,1))
hist(energyDF$Global_active_power, col=rgb(255,37,0,max=255), main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
