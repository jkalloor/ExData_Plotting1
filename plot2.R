#Plot 2
library(dplyr)
library(reshape2)
infile<- "C:/Users/JOSEPH/Downloads/Data-analysis/EDA/data/household_power_consumption.txt"
epcdata<-read.table(infile, header = TRUE, sep = ";", 
                               na.strings = "?", nrows = 10,
                                skip = 0,  
                                stringsAsFactors = default.stringsAsFactors(),
                     )
classesx <- sapply(epcdata, class)
epcdata<-read.table(infile, header = TRUE, sep = ";", 
                  na.strings = "?", 
                  skip = 0,  
                  stringsAsFactors = default.stringsAsFactors(),
                  colClasses = classesx
)
epcdata1 <- tbl_df(epcdata)
#select only the required data using filter
epc1 <- filter(epcdata1,Date == "1/2/2007" | Date == "2/2/2007")
#remove the big tables.
rm(epcdata)
rm(epcdata1)
epc2 <- mutate(epc1, Date1 = as.Date(Date, format = "%d/%m/%Y") )
#combine date & Time craete one variable. 
epc3 <- mutate(epc2,DT = paste(Date1,Time))
epc4 <- mutate(epc3,DateTime=  as.POSIXct(strptime(DT, "%Y-%m-%d %H:%M:%S")))

png(file = "EDA/plot2.png", bg = "transparent")
with(epc4, plot(DateTime, Global_active_power,type="l" ,ylab="Global Active Power(kilowatts)",xlab=""))
dev.off()
