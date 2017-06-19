
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

ds$Date<-as.POSIXct(paste(ds$Date, ds$Time), format="%d/%m/%Y %H:%M:%S")

#ds<-read.csv.sql(file,sep=";",sql="select * strftime('%d/%m/%Y', Date) as DateFormated from file where DateFormatted >= 1/2/2007 and DateFormatted <= 2/2/2007 ")
png("plot3.png", width = 480, height = 480)
plot(ds$Date,ds$Sub_metering_1, type="l", ylab="Energy sub metering",xlab="")
lines(ds$Date, ds$Sub_metering_2,col="red")
lines(ds$Date, ds$Sub_metering_3,col="blue")
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3") ,lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.75)

dev.off()