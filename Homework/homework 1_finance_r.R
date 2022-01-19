# importing quantmod library
library(quantmod)

# importing netflix data
netflix = getSymbols('NFLX', from = '2003-01-01', to = '2020-12-31', auto.assign = F)

# reporting summary statistics of netflix close
summary(netflix$NFLX.Close)

# creating scatter plot of close price over time
plot(netflix$NFLX.Close, xlab = 'Date', ylab = 'Volume', main ='Netflix Closing Price Trade')
## as time goes on, Netflix increases in price exponentially past 2010

# subsetting stock data from 2020 
netflix2020data = subset(netflix, index(netflix) >= '2020-01-01' & index(netflix) <= '2020-12-31')

# sorting netflix2020data
order(netflix2020data$NFLX.Volume[,1])
netflix2020data$NFLX.Volume[249]

# The date with the lowest volume of trades is 12-24-2020, with the number of trades being 1,144,000



