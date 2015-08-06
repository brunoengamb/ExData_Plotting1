# Downloading the raw data set
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="consumption.zip") 
unzip("consumption.zip")
consump<- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
# Converting Date and time
dates <- as.vector(consump$Date) 
times <- as.vector(consump$Time)
X <- paste(dates, times)
X<- strptime(X, "%d/%m/%Y %H:%M:%S")
consump<- cbind(as.Date(X),consump)
names(consump)<- c("Data_x", "Data", "Time", "Global_active_power","Global_reactive_power",
                   "Voltage", "Global_intensity", "Sub_metering_1",
                   "Sub_metering_2", "Sub_metering_3")

# Subseting to a new data frame
sub<- subset(consump, Data_x >= as.Date("2007-02-01") & Data_x <= as.Date("2007-02-02"),
             select = c(Data_x, Global_active_power, Global_reactive_power, Voltage, Global_intensity,
                        Sub_metering_1, Sub_metering_2, Sub_metering_3))

# Ploting a Histogram 
hist(as.numeric(sub$Global_reactive_power), main = "Global Active Power",
     xlab ="Global Active Power (kW)")

# Exporting the graph as PNG image
png(filename="plot1.png", width = 480, height = 480, units = "px")
hist(as.numeric(sub$Global_reactive_power), main = "Global Active Power",
     xlab ="Global Active Power (kW)")
dev.off()
