## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008?

# Read in the data
codes <- readRDS('Source_Classification_Code.rds')
pm <- readRDS('summarySCC_PM25.rds')

# Find data for Baltimore
baltimore <- subset(pm, fips == '24510')
emissions <- tapply(baltimore$Emissions, baltimore$year, sum, na.rm=TRUE)
years <- as.numeric(names(emissions))

# Produce graph showing change in emissions over time for Baltimore
png(filename='plot2.png')

plot(years, emissions,
     xlab='Year', ylab='Total emissions (tons)', 
     main='Fine Particulate Matter Emissions in Baltimore',
     pch=19)
lines(years, emissions)

dev.off()
