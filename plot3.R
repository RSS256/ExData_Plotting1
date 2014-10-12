plot3 <- function() {

## Note: This script assumes that the data file "household_power_consumption.txt" has already been downloaded from the Internet
##      and is in your R working directory.
        
## STAGE 1: READ DATA FROM TXT DATA FILE INTO AN R DATA FRAME NAMED "two_days".
        ## a.  take only that subset of the data for which the date is February 1st or 2nd, 2007.
        ## b.  set na.strings="?" to address use of question mark to designate missing data.
        ## c.  use sep=";" to accomodate use of semicolon to delimit data.
        two_days <- subset(read.table(file="household_power_consumption.txt",sep=";",header=TRUE,na.strings="?"),Date=="1/2/2007" | Date=="2/2/2007")
        
## STAGE 2: RECONFIGURE/REFORMAT DATE AND TIME DATA TO SUPPORT GRAPHING
        ## a.  reformat the "Date" field to have date format.
        two_days$Date <- as.Date(two_days$Date,format="%d/%m/%Y")
        
        ## b.  combine the "Date" and "Time" fields into a new field, "DateTime"
        two_days$DateTime <- paste(two_days$Date,two_days$Time)
        
        ## c.  reformat the "DateTime" field from characters the "POSIXlt" class 
        two_days$DateTime <- strptime(two_days$DateTime, "%Y-%m-%d %H:%M:%S")

        
## STAGE 3: GENERATE THE PLOT
        ## a.  set type="n" to generate plot framework without any data visible
        plot(two_days$DateTime,two_days$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
        
        ## b.  add lines reflecting data from "Sub_metering_1" field (defaults to color black)
        lines(two_days$DateTime,two_days$Sub_metering_1)
        
        ## c.  add red lines reflecting data from "Sub_metering_2" field
        lines(two_days$DateTime,two_days$Sub_metering_2,col="red")
        
        ## d.  add blue lines reflecting data from "Sub_metering_3" field
        lines(two_days$DateTime,two_days$Sub_metering_3,col="blue")
        
        ## e.  add legend
        ##    i. set cex=0.75 to reduce size of text to allow it to fit within the legend box
        ##    ii. set lty=1 to get lines
        legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.75,lty=1,col=c("black","red","blue"))
        
        
## STAGE 4: COPY THE PLOT TO A PNG FILE OF DIMENSIONS 480 X 480.
        dev.copy(png,file="plot3.png",width=480,height=480)
        dev.off()

}