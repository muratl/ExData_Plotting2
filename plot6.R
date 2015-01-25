# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == 06037). Which city has seen greater changes over time in motor vehicle emissions?


library(plyr)
library(ggplot2)

# Read the data file
SCC_PM25 <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

cities <- SCC_PM25[SCC_PM25$fips == "24510"|SCC_PM25$fips == "06037", ]

motor <- grep("motor", SCC$Short.Name, ignore.case = T)
motor <- SCC[motor, ]
motor <- cities[cities$SCC %in% motor$SCC, ]


par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./plot6.png", width = 480, height = 480, units = "px")

ggplot(motor, aes(year, Emissions, color = fips)) + geom_line(stat = "summary", fun.y = "sum") +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle("Comparison of Total Emissions From Motor\n Vehicle Sources in Baltimore City\n and Los Angeles County from 1999 to 2008") +
    scale_colour_discrete(name = "Group", label = c("Los Angeles","Baltimore"))

dev.off()
