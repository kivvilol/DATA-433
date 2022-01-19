# importing quantmod
library(quantmod)

# importing ebay stock data
ebay = getSymbols('EBAY', from = '2020-01-01', to = '2020-12-31', auto.assign = F)
head(ebay)

# selecting 01/06/2020 and 02/06/2020 data
ebay1 = subset(ebay, index(ebay) %in% as.Date(c('2020-01-06', '2020-02-06')), select = EBAY.Adjusted)
ebay1$total_return = Delt(ebay1$EBAY.Adjusted)

# selecting 11/09/2020 and 12/09/2020 data
ebay2 = subset(ebay, index(ebay) %in% as.Date(c('2020-11-09', '2020-12-09')), select = EBAY.Adjusted)
ebay2$total_return = Delt(ebay2$EBAY.Adjusted)

# The time frame with the highest total return is from 01/06/2020 and 02/06/2020


