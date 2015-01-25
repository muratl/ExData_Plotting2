# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(plyr)
library(ggplot2)

# Read the data file
SCC_PM25 <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

baltimoreMV <- subset(SCC_PM25, fips == "24510" & type=="ON-ROAD")

baltimoreMVPM25ByYear <- ddply(baltimoreMV, .(year), function(x) sum(x$Emissions))
colnames(baltimoreMVPM25ByYear)[2] <- "Emissions"

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./plot5.png", width = 480, height = 480, units = "px")

qplot(year, Emissions, data=baltimoreMVPM25ByYear, geom="line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
  xlab("Year") +
  ylab("Total Emissions From Motor Vehicle Sources\n from 1999 to 2008 in Baltimore City")

dev.off()
