# 2. # Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Read the data file
SCC_PM25 <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

baltimoreData <- subset(SCC_PM25, fips == "24510")

totalPM25ByYear <- tapply(baltimoreData$Emissions, baltimoreData$year, sum)

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./plot2.png", width = 480, height = 480, units = "px")

plot(names(totalPM25ByYear), totalPM25ByYear, type="l", xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),  main="Total Emissions in Baltimore City from 1999 to 2008")

dev.off()
