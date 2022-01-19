# loading quantmod
library(quantmod)

# download ebay stock data
ebay = getSymbols('EBAY', from = '2019-01-01', to = '2020-12-31', auto.assign = F)

# computing 20 day moving average and standard deviation
ebay$MA = rollmean(ebay$EBAY.Close, k = 20, align = 'right')
ebay$SD = rollapply(ebay$EBAY.Close, width = 20, FUN = sd, fill = NA)

# computing bollinger bands
ebay$low = ebay$MA - 2*ebay$SD
ebay$high = ebay$MA + 2*ebay$SD

# plotting bollinger bands
plot(as.Date(index(ebay)), ebay$EBAY.Close, type = 'l', lwd = 2, col = 'black', xlab = 'Date', ylab = 'Close Price ($)')
lines(as.Date(index(ebay)), ebay$MA, lwd = 2, col = 'blue')
lines(as.Date(index(ebay)), ebay$low, lwd = 2, col = 'brown')
lines(as.Date(index(ebay)), ebay$high, lwd = 2, col = 'brown')

# The 20 day moving average appears to follow the trend closely. The price appears to drop around March of 2020, likely due to COVID.
# Around June, the price keeps increasing. 