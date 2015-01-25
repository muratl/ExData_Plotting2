# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5² emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Read the data file
SCC_PM25 <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

totalPM25ByYear <- tapply(SCC_PM25$Emissions, SCC_PM25$year, sum)

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./plot1.png", width = 480, height = 480, units = "px")

plot(names(totalPM25ByYear), totalPM25ByYear, type="l", xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),  main="Total Emissions in the United States from 1999 to 2008")

dev.off()
