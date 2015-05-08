#plot1.R
#Read electric power data  and plot base graphics. 
library(dplyr)
library(reshape2)
#read few records the in putfile .
infile<- "C:/Users/JOSEPH/Downloads/Data-analysis/EDA/data/household_power_consumption.txt"
epcdata<-read.table(infile, header = TRUE, sep = ";", 
                               na.strings = "?", nrows = 10,
                                skip = 0,  
                                stringsAsFactors = default.stringsAsFactors(),
                     )
classesx <- sapply(epcdata, class)
#now read complete file.
epcdata<-read.table(infile, header = TRUE, sep = ";", 
                  na.strings = "?", 
                  skip = 0,  
                  stringsAsFactors = default.stringsAsFactors(),
                  colClasses = classesx
)
epcdata1 <- tbl_df(epcdata)
# select the rquired data using filter:
epc1 <- filter(epcdata1,Date == "1/2/2007" | Date == "2/2/2007")
#remove  big data we no more need.  
rm(epcdata)
rm(epcdata1)
epc2 <- mutate(epc1, Date1 = as.Date(Date, format = "%d/%m/%Y") )
epc3 <- mutate(epc2,DT = paste(Date1,Time))
epc4 <- mutate(epc3,DateTime=  as.POSIXct(strptime(DT, "%Y-%m-%d %H:%M:%S")))
png(file = "EDA/plot1.png", bg = "transparent")
hist(epc4$Global_active_power, col = "red",main= "Global Active Power",xlab='Global Active Power (kilowatts)')
title("Plot1",outer=TRUE,adj=0,line= -1)
dev.off()
