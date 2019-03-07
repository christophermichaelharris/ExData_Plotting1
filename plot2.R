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
  colnames(data) <- c("Date","Time","GlobalActivePower","GlobalReactivePower","Voltage","GlobalIntensity","SubMetering1","SubMetering2","SubMetering3")
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  observations <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")
  
}

par(mfrow=c(1,1))

kWGAP <- as.numeric(as.character(observations$GlobalActivePower))   ##Creates variable for the plot
datetime <- as.POSIXct(paste(observations$Date,observations$Time))
plot(datetime,kWGAP,type="l",ylab = "Global Active Power (kilowatts)",xlab="")

