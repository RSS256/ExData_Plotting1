plot2 <- function() {


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

##  STAGE 3: PLOT THE GRAPH
        ## set type="l" to create a line graph
        plot(two_days$DateTime,two_days$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
        
##  STAGE 4: COPY THE GRAPH TO A PNG FILE OF DIMENSIONS 480 X 480.
        dev.copy(png,file="plot2.png",width=480,height=480)
        dev.off()
 
}