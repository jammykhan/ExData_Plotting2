## Have total emissions from PM2.5 decreased in the United States from 1999 to 
## 2008?

# Read in the data
codes <- readRDS('Source_Classification_Code.rds')
pm <- readRDS('summarySCC_PM25.rds')

# Sum up emissions for each year that data was recorded
total.emissions <- tapply(pm$Emissions, pm$year, sum, na.rm=TRUE)
years <- as.numeric(names(total.emissions))

# Produce graph showing change in emissions over time
png(filename='plot1.png')
plot(years, total.emissions,
     xlab='Year', ylab='Total emissions (tons)', 
     main='Fine Particulate Matter Emissions',
     pch=19)
lines(years, total.emissions)
dev.off()
