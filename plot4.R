filename <- "Electric Power Consumption.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

##Below code checks if file is already on the global environment
##If not, it downloads, reads it, and cleans it up
##It then assigns appropriate column names
##Then it subsets based on the desired 2007-02-01 and 2007-02-02 dates


if(!file.exists(filename)){      ##checks if file has already been downloaded
  download.file(url,filename)     ##downloads if file doesn't exist yet
  unzip(filename)
  data <- read.table("household_power_consumption.txt",sep=";")
  data <- data[-1,]
  colnames(data) <- c("Date","Time","GlobalActivePower","GlobalReactivePower","Voltage","GlobalIntensity","Sub_Metering1","Sub_Metering2","Sub_Metering3")
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  observations <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")
  
}

par(mfcol=c(2,2))   ##creates a plot with 2 columns and 2 rows

##Repeat of plot2 as top left plot
kWGAP <- as.numeric(as.character(observations$GlobalActivePower))   ##Creates variable for the plot
datetime <- as.POSIXct(paste(observations$Date,observations$Time))
plot(datetime,kWGAP,col="white",ylab = "Global Active Power (kilowatts)",xlab="")
lines(datetime,kWGAP)

##Repeat of plot3 as bottom left plot
datetime <- as.POSIXct(paste(observations$Date,observations$Time))
SM1 <- as.numeric(as.character(observations$SubMetering1))   
SM2 <- as.numeric(as.character(observations$SubMetering2))   
SM3 <- as.numeric(as.character(observations$SubMetering3))  
plot(datetime,SM1,type="l",ylab="Energy sub metering",xlab="")
lines(datetime,SM2,col="red")
lines(datetime,SM3, col="blue")
legend("topright",lty=1,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),cex=.5)


##Creates a new plot using voltage for top right graph
Voltage <- as.numeric(as.character(observations$Voltage))
plot(datetime,Voltage,col="white")
lines(datetime,Voltage,col="black")

##Creates a new plot using global reactive power for bottom right
GlobReactPwr <- as.numeric(as.character(observations$GlobalReactivePower))
plot(datetime,GlobReactPwr,col="white",ylab="Global_reactive_power")
lines(datetime,GlobReactPwr,col="black")

