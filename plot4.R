plot4 <- function() {
        
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
        
## STAGE 3: CONFIGURE GRAPHICS DEVICE TO ACCOMODATE 4 PLOTS
        ## use mfcol so that plots will consecutively occupy upper left, lower left, upper right, and lower right positions.
        par(mfcol=c(2,2))

## STAGE 4a: GENERATE THE 1ST PLOT
        ## set type="l" to generate a line graph
        plot(two_days$DateTime,two_days$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
        
## STAGE 4b: GENERATE THE 2ND PLOT
        ## set type="n" to generate framework of plot without showing data
        plot(two_days$DateTime,two_days$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")

        ## add lines reflecting data from "Sub_metering_1" field (defaults to color black)
        lines(two_days$DateTime,two_days$Sub_metering_1)

        ## add red lines reflecting data from "Sub_metering_2" field
        lines(two_days$DateTime,two_days$Sub_metering_2,col="red")

        ## add blue lines reflecting data from "Sub_metering_3" field
        lines(two_days$DateTime,two_days$Sub_metering_3,col="blue")
        
        ## add legend 
        ##    set cex=0.50 to reduce size of text to allow it to fit within legend box
        ##    set lty=1 to get lines
        legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.50,lty=1,col=c("black","red","blue"))
        
        
## STAGE 4c: GENERATE THE 3RD PLOT        
        plot(two_days$DateTime,two_days$Voltage,type="l",xlab="datetime",ylab="Voltage")
        
        
## STAGE 4d: GENERATE THE 4TH PLOT        
        plot(two_days$DateTime,two_days$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
        
        
## STAGE 5: COPY THE PLOTS TO A PNG FILE WITH DIMENSIONS 480 X 480        
        dev.copy(png,file="plot4.png",width=480,height=480)
        dev.off()
       
        
}  ## End of "plot4" function