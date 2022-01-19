# loading quantmod
library(quantmod)

# download ebay data
ebay = getSymbols('EBAY', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

# computing total returns
ebay$total_return = Delt(ebay$EBAY.Adjusted)

# adding 1 to total returns
ebay$total_return_1 = ebay$total_return + 1

# removing NA
ebay = na.omit(ebay)

# computing cumulative returns
ebay$gross_cum = cumprod(ebay$total_return_1)

# computing net returns
ebay$net_cum = ebay$gross_cum - 1

# the return will be 41.25% if you hold the investment for the entire year.

