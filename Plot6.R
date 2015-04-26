## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California 
## (fips == "06037"). Which city has seen greater changes over time in motor 
## vehicle emissions?

# Read in the data
codes <- readRDS('Source_Classification_Code.rds')
pm <- readRDS('summarySCC_PM25.rds')

# Find motor vehicle related codes from Baltimore City or LA County
balt.la.pm <- subset(pm, fips == '24510' | fips == '06037')
balt.la.pm <- merge(x=balt.la.pm, y=codes, by='SCC')
idx <- grep('vehicle', x=balt.la.pm$EI.Sector, ignore.case=TRUE)
balt.la.motor <- balt.la.pm[idx,]

library(reshape2)
balt.la.d <- dcast(balt.la.motor, year ~ fips, 
                   fun.aggregate=sum, value.var='Emissions')
balt.la.m <- melt(balt.la.d, 
                  measure.vars=c('24510', '06037'), 
                  value.name='emissions', variable.name='fips')

# Make comparative plot
library(ggplot2)
png(filename='plot6.png')

g <- ggplot(balt.la.m, aes(year, emissions)) + 
  geom_line(aes(color=factor(fips, labels=c('Baltimore City',
                                            'Los Angeles County')))) +
  xlab('Year') + ylab('Emissions (tons)') + 
  ggtitle('Motor Vehicle Emissions: Baltimore City vs Los Angeles County') + 
  theme(legend.title=element_blank())

print(g)

dev.off()
