# importing quantmod
library(quantmod)

# importing Bank of America stock data
america <-  getSymbols('BAC', from = '2019-01-01', to = '2020-01-01', auto.assign = F)

# calculating RSI
americaRSI <- RSI(america$BAC.Close, n = 50, maType = 'WMA')

plot(americaRSI, main = 'Bank of America RSI', col = 'blue', lwd = 2, type = 'l')

# The plot does not appear to be consistent. However, there does appear to be a slight upward trend.
# Potential buy opportunities include the end of March 2019, the middle of May 2019, and the end of 
# August 2019. Potential sell opportunities include the beginning of March 2019, the beginning of
# May 2019, and the end of December 2019.