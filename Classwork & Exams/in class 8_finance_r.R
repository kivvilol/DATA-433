# importing quantmod
library(quantmod)

# importing stock data
wellsfargo <-  getSymbols('WFC', from = '2020-10-01', to = '2020-12-31', auto.assign = F)
america <-  getSymbols('BAC', from = '2020-10-01', to = '2020-12-31', auto.assign = F)
