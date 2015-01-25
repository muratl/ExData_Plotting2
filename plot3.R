# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

library(plyr)
library(ggplot2)

# Read the data file
SCC_PM25 <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

baltimoreData <- subset(SCC_PM25, fips == "24510")

typePM25ByYear <- ddply(baltimoreData, .(year, type), function(x) sum(x$Emissions))
colnames(typePM25ByYear)[3] <- "Emissions"

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./plot3.png", width = 480, height = 480, units = "px")

#plot(names(totalPM25ByYear), totalPM25ByYear, type="l", xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),  main="Total Emissions in Baltimore City from 1999 to 2008")
qplot(year, Emissions, data=typePM25ByYear, color=type, geom="line") + ggtitle("Total Emissions in Baltimore City from 1999 to 2008") + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

dev.off()
