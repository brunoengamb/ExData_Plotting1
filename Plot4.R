# Downloading the raw data set
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="consumption.zip") 
unzip("consumption.zip")
consump<- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
# Converting Date and time
dates <- as.vector(consump$Date) 
times <- as.vector(consump$Time)
X <- paste(dates, times)
X<- strptime(X, "%d/%m/%Y %H:%M:%S")
dados<- cbind(as.Date(X),consump)
names(dados)<- c("Data_x", "Date", "Time", "Global_active_power","Global_reactive_power",
                 "Voltage", "Global_intensity", "Sub_metering_1",
                 "Sub_metering_2", "Sub_metering_3")

# Subseting to a new data frame
sub<- subset(dados, Data_x >= as.Date("2007-02-01") & Data_x <= as.Date("2007-02-02"),
             select = c(Data_x, Date, Time, Global_active_power, Global_reactive_power, Voltage, Global_intensity,
                        Sub_metering_1, Sub_metering_2, Sub_metering_3))
#Getting corect date time

dates <- as.vector(sub$Date) 
times <- as.vector(sub$Time)
Y <- paste(dates, times)
Y<- strptime(Y, "%d/%m/%Y %H:%M:%S")
dados<- cbind(Y,sub)

# Ploting a the graphcs 

y1<- as.numeric(dados$Global_active_power)
y2<- as.numeric(dados$Voltage)
y3<- as.numeric(dados$Sub_metering_1)
y4<- as.numeric(dados$Sub_metering_2)
y5<- as.numeric(dados$Sub_metering_3)
y6<- as.numeric(dados$Global_reactive_power)
x<- (dados[,1])
par(mfrow = c(2,2))
plot(x,y1, type = "l", ylab = "Global Active Power (watt)", xlab = "")
plot(x, y2, type = "l", ylab = "Voltage (V)", xlab = "" )
plot(x,y3, type = "l", ylab = "Energy sub metering (watt/hour of active energy)", xlab = "")
lines(x,y4, col ="red")
lines(x,y5, col ="blue")
plot(x,y6, type = "l", ylab = "Global Reactive Power (watt)", xlab = "")

# Exporting the graphcs as PNG image
png(filename="plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
plot(x,y1, type = "l", ylab = "Global Active Power (watt)", xlab = "")
plot(x, y2, type = "l", ylab = "Voltage (V)", xlab = "" )
plot(x,y3, type = "l", ylab = "Energy sub metering (watt/hour of active energy)", xlab = "")
lines(x,y4, col ="red")
lines(x,y5, col ="blue")
plot(x,y6, type = "l", ylab = "Global Reactive Power (watt)", xlab = "")
dev.off()







