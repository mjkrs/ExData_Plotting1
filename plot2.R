
#url of the source
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#name of zip file
zfile<-"householdElectric.zip"

#download the zip file
download.file(url, zfile)

#unzip to current folder
unzip(zfile,exdir=".")

#memory usage
#mem<-2075259*9*8*(2^20)

#file
file<-"household_power_consumption.txt"
library(sqldf)
ds<-read.csv.sql(file,sep=";",sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007' ")

dt<-sqldf("select Date, Time, Global_active_power from ds")
dt$Date<-as.POSIXct(paste(dt$Date, dt$Time), format="%d/%m/%Y %H:%M:%S")

png("plot2.png", width = 480, height = 480)
plot(dt$Date,dt$Global_active_power, type="l", ylab="Global Active Power(kilowatts)",xlab="")

dev.off()