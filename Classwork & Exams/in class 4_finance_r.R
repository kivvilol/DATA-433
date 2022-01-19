# importing quantmod
library(quantmod)

# importing netflix stock data
netflix = getSymbols('NFLX', from = '2019-01-01', to = '2020-12-31', auto.assign = F)

# importing disney stock data
disney = getSymbols('DIS', from = '2019-01-01', to = '2020-12-31', auto.assign = F)

# selecting close price
close_price = data.frame(cbind(netflix$NFLX.Close, disney$DIS.Close))
head(close_price)

# computing the index
close_price$NFLX_Index = close_price$NFLX.Close / close_price$NFLX.Close[1]
close_price$DIS_Index = close_price$DIS.Close / close_price$DIS.Close[1]
head(close_price)

# visualizing the indexes
plot(as.Date(row.names(close_price)), close_price$NFLX_Index, xlab = 'Data', ylab = 'Stock index', lty = 1, lwd = 2, col = 'blue')
lines(as.Date(row.names(close_price)), close_price$DIS_Index, lwd = 2, col = 'orange')

# netflix performed better than disney because the dollar amount is higher on 12-31-2020 th an disney is