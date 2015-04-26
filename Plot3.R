## Of the four types of sources indicated by the type (point, nonpoint, onroad, 
## nonroad) variable, which of these four sources have seen decreases in 
## emissions from 1999-2008 for Baltimore City? Which have seen increases in 
## emissions from 1999-2008? 

# Read in the data
codes <- readRDS('Source_Classification_Code.rds')
pm <- readRDS('summarySCC_PM25.rds')

# Find data for Baltimore
library(reshape2)
baltimore <- subset(pm, fips == '24510')
baltimore.d <- dcast(baltimore, year ~ type, 
                     fun.aggregate=sum, value.var='Emissions')
baltimore.m <- melt(baltimore.d, 
                    measure.vars=c('NON-ROAD', 'NONPOINT', 'ON-ROAD','POINT'), 
                    value.name='emissions', variable.name='type')

# Make comparative plot
library(ggplot2)
png(filename='plot3.png')

g <- ggplot(baltimore.m, aes(year, emissions)) + 
  geom_line(aes(color=type)) +
  xlab('Year') + ylab('Emissions (tons)') + 
  ggtitle('Emissions by Type')

print(g)

dev.off()
