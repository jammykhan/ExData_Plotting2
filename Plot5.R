## How have emissions from motor vehicle sources changed from 1999-2008 in 
## Baltimore City?

# Read in the data
codes <- readRDS('Source_Classification_Code.rds')
pm <- readRDS('summarySCC_PM25.rds')

# Find motor vehicle related codes from Baltimore City
baltimore.pm <- subset(pm, fips == '24510')
baltimore.pm <- merge(x=baltimore.pm, y=codes, by='SCC')
idx <- grep('vehicle', x=baltimore.pm$EI.Sector, ignore.case=TRUE)
balt.motor <- baltimore.pm[idx,]

# Make small data frame for plotting
emissions <- tapply(balt.motor$Emissions, balt.motor$year,
                    sum, na.rm=TRUE)
years <- as.numeric(names(emissions))
emissions.df <- data.frame(years, emissions)

# Plot time vs emissions
library(ggplot2)

png(filename='plot5.png')

g <- ggplot(emissions.df, aes(years, emissions)) + geom_line() +
  xlab('Year') + ylab('Emissions') + 
  ggtitle('Motor Vehicle Emissions in Baltimore City')
print(g)

dev.off()
