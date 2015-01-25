# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library(plyr)
library(ggplot2)

# Read the data file
SCC_PM25 <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

coalSCC <- subset(SCC, grepl("Coal", Short.Name, ignore.case = TRUE))

coalCombustion <- subset(SCC_PM25, SCC %in% coalSCC$SCC)

coalCombustionPM25ByYear <- ddply(coalCombustion, .(year, type), function(x) sum(x$Emissions))
colnames(coalCombustionPM25ByYear)[3] <- "Emissions"

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./plot4.png", width = 480, height = 480, units = "px")

qplot(year, Emissions, data=coalCombustionPM25ByYear, color=type, geom="line") +
  stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", 
               color = "black", aes(shape="total"), geom="line") +
  geom_line(aes(size="total", shape = NA)) +
  ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

dev.off()
