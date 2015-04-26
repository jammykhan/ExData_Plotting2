## Across the United States, how have emissions from coal combustion-related
## sources changed from 1999–2008?

# Read in the data
codes <- readRDS('Source_Classification_Code.rds')
pm <- readRDS('summarySCC_PM25.rds')

# Find coal combustion-related codes
coal <- grepl('coal', codes$Short.Name, ignore.case=TRUE)
comb <- grepl('comb', codes$Short.Name, ignore.case=TRUE)
scc <- codes[coal & comb, 'SCC']

# Use codes to find subset of emissions table`
emissions <- subset(pm, SCC %in% scc)

# Find annual emissions
total.emissions <- tapply(emissions$Emissions, emissions$year, sum, na.rm=TRUE)
years <- as.numeric(names(total.emissions))

# Plot coal combustion-related emissions from 1999-2008.
png(filename='plot4.png')

plot(years, total.emissions, xlab='Year', ylab='Total emissions (tons)',
     main='Coal combustion-related emissions', pch=19)
lines(years, total.emissions)

dev.off()
