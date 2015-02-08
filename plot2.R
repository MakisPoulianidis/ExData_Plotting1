## Exploratory Data Analysis: Course Project 1
## 2015-02-08 bankbintje
## Build and tested on 
        # R version 3.1.1 
        # R Studio Version 0.98.1062   
        # Mac (x86_64-apple-darwin13.1.0)

plot2 <- function () {
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

## NB both stepd could be done using read.csv.sql However this does not support the na.strings="?" option
## alternative
## require(sqldf)
## hpc_subset <- read.csv.sql(household_power_consumption, header = TRUE, 
### sep = ";", sql = "select * from file where (Date == '1/2/2007'OR Date == '2/2/2007')")

## CLEANUP DATA 
## not much cleaning to do, the NA's 
## paste hpc_subset$Date and hpc_subset$Time and convert to a Date
hpc_subset$Date.Time <- 
        strptime(paste(hpc_subset$Date, hpc_subset$Time),  format = "%d/%m/%Y %H:%M:%S")

## set the locale to English to 
Sys.setlocale("LC_TIME", "C")


## Make a plot using "plot"
plot(hpc_subset$Date.Time,hpc_subset$Global_active_power,
        xlab="", 
        ylab="Global Active Power (kilowats)",
        width = 480, ## set width
        height = 480, ## set height
        bg = "white", ## set background colour
        type="l")

## write the plot to the wd()
dev.copy(png, file = "plot2.png")

## close the device...
dev.off()

## ...and clean up 
rm (hpc_subset)
setwd("..")
}