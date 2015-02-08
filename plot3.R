## Exploratory Data Analysis: Course Project 1
## 2015-02-08 bankbintje
## Build and tested on 
# R version 3.1.1 
# R Studio Version 0.98.1062   
# Mac (x86_64-apple-darwin13.1.0)

plot3 <- function () {
        options(warn=-1)          
        
        ## LOAD DATA 
        
        ## check if the workdirectory exists. Create it if it doesn't exist yet
        if(!file.exists("./ExData_Plotting1")){dir.create("./ExData_Plotting1")}
        setwd("./ExData_Plotting1")
        
        ## check if the datadirectory exists. Create it if it doesn't exist yet
        if(!file.exists("./dataEPC")){dir.create("./dataEPC")}
        
        ## set the file URL
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        
        ## check if the download file exists. Download it if it doesn't exist 
        if(!file.exists("./dataEPC/exdata_data_household_power_consumption.zip"))
        {download.file(fileUrl,destfile="./dataEPC/exdata_data_household_power_consumption.zip",
                       method="curl")}
        
        ## check if the unzipped file exists. Unzip it if it doesn't exist 
        if(!file.exists("./dataEPC/household_power_consumption.txt"))
        {unzip("./dataEPC/exdata_data_household_power_consumption.zip", exdir = "./dataEPC")}
        
        ## put the filename into a variable
        household_power_consumption <- c("./dataEPC/household_power_consumption.txt")
        
        ## load all the data and replace the "?" with NA
        hpc_fullset <- read.csv(household_power_consumption, header = TRUE, sep =";", 
                                stringsAsFactors = FALSE, na.strings="?")
        
        ## load only the data that is needed.
        hpc_subset <- dplyr::filter(hpc_fullset,Date == '1/2/2007'|Date == '2/2/2007')
        
        ## remove the fullset to free up mem
        rm (hpc_fullset)
        
        ## CLEANUP DATA 
        ## not much cleaning to do, the NA's 
        ## paste hpc_subset$Date and hpc_subset$Time and convert to a Date
        hpc_subset$Date.Time <- 
                strptime(paste(hpc_subset$Date, hpc_subset$Time),  format = "%d/%m/%Y %H:%M:%S")
        
        ## set the locale to English to 
        Sys.setlocale("LC_TIME", "C")
        
        ## open a graphics device
        png(filename = "plot3.png", 
            width = 480, 
            height = 480, 
            units = "px", 
            bg = "white" )
        
        ## Make a plot using "plot"
        plot(hpc_subset$Date.Time,hpc_subset$Sub_metering_1,
             col = "black",
             xlab="", 
             ylab="Energy sub metering",
             bg = "white", 
             type="l")        
        
        ## add a 2nd line to the plot using "lines"
        lines(hpc_subset$Date.Time,hpc_subset$Sub_metering_2,
             col = "red",
             xlab="", 
             ylab="Energy sub metering",
             bg = "white", 
             type="l")
        
        ## add a 3nd line to the plot using "lines"
        lines(hpc_subset$Date.Time,hpc_subset$Sub_metering_3,
              col = "blue",
              xlab="", 
              ylab="Energy sub metering",
              bg = "white", 
              type="l")
        
        ## add a legend to the plot
        legend("topright", 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               col = c("black", "red", "blue"),
               y.intersp = 2.5,
               lwd = .75, 
               cex = .75)
        
        ## close the device...
        dev.off()
        
        ## ...and clean up 
        rm (hpc_subset)
        setwd("..")
}