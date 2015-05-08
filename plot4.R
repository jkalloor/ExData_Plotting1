#plot4.R
library(dplyr)
library(reshape2)
infile<- "C:/Users/JOSEPH/Downloads/Data-analysis/EDA/data/household_power_consumption.txt"
#read a few records and get the colclasses
epcdata<-read.table(infile, header = TRUE, sep = ";", 
                               na.strings = "?", nrows = 10,
                                skip = 0,  
                                stringsAsFactors = default.stringsAsFactors(),
                     )
classesx <- sapply(epcdata, class)
#Read complete data
epcdata<-read.table(infile, header = TRUE, sep = ";", 
                  na.strings = "?", 
                  skip = 0,  
                  stringsAsFactors = default.stringsAsFactors(),
                  colClasses = classesx
)
epcdata1 <- tbl_df(epcdata)
epc1 <- filter(epcdata1,Date == "1/2/2007" | Date == "2/2/2007")
#remove big table we do not need anymore.
rm(epcdata)
rm(epcdata1)
epc2 <- mutate(epc1, Date1 = as.Date(Date, format = "%d/%m/%Y") )
 
epc3 <- mutate(epc2,DT = paste(Date1,Time))
epc4 <- mutate(epc3,DateTime=  as.POSIXct(strptime(DT, "%Y-%m-%d %H:%M:%S")))

png(file = "EDA/plot4.png", bg = "transparent")
par(mfrow= c(2,2))
with(epc4,plot(DateTime,Global_active_power,type="l",col="black",ylab="Global Active Power",xlab="" ))
with(epc4,plot(DateTime,Voltage,type="l",col="black",ylab="Voltage",xlab="datetime" ))
with(epc4,plot(DateTime,Sub_metering_1,type="l",col="black",ylab="Energy sub metering",xlab="")) 
with(epc4,lines(DateTime,Sub_metering_2,type="l",col="red"  ))
with(epc4,lines(DateTime,Sub_metering_3,type="l",col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.9,bty = "n")
with(epc4,plot(DateTime,Global_reactive_power,type="l",col="black",ylab="Global_reactive_power",xlab="datetime" ))
title("Plot4",outer=TRUE,adj=0,line= -1)
dev.off()
