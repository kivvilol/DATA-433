# importing quantmod
library(quantmod)

# importing wells fargo and bank of america stock data
wells = getSymbols('WFC', from = '2019-01-01', end = '2020-01-01', auto.assign = F)
america = getSymbols('BAC', from = '2019-01-01', end = '2020-01-01', auto.assign = F)

# selecting close prices
close_prices = data.frame(cbind(wells$WFC.Adjusted, america$BAC.Adjusted))

# computing indexes
close_prices$WFC_index = close_prices$WFC.Adjusted / close_prices$WFC.Adjusted[1]
close_prices$BAC_index = close_prices$BAC.Adjusted / close_prices$BAC.Adjusted[1]

# visualizing the indexes
plot(as.Date(rownames(close_prices)), close_prices$WFC_index, type = 'l', xlab = 'Date', ylab = 'Stock Index', col = 'blue', lwd = 2, ylim = c(0, 2.5))
lines(as.Date(rownames(close_prices)), close_prices$BAC_index, col = 'red', lwd = 2)
legend('topleft', lwd = c(2,2), col = c('blue', 'red'), c('WFC Index', 'BAC Index'))

# The Bank of America stock is performing better than Wells Fargo.


# computing 50-day moving averages
wells$MA_50 = rollmean(wells$WFC.Adjusted, k = 50, align = 'right')
america$MA_50 = rollmean(america$BAC.Adjusted, k = 50, align = 'right')

# converting data to data-frame
wells2 = data.frame(wells)
america2 = data.frame(america)

# plotting stock prices of wells fargo w/ 50-day moving average
plot(as.Date(rownames(wells2)), wells2$WFC.Adjusted, type = 'l', lwd = 2, xlab = 'Date', ylab = 'Wells Fargo Stock Price ($)')
lines(as.Date(rownames(wells2)), wells2$MA_50, col = 'red', lwd = 2)

# The 50-day moving average is higher than the stock price around 2020. 
# However, around october-november of 2020 the moving-average dips below the stock price.

# plotting stock price of bank of america w/ 50-day moving average
plot(as.Date(rownames(america2)), america2$BAC.Adjusted, type = 'l', lwd = 2, xlab = 'Date', ylab = 'Bank of America Stock Price ($)')
lines(as.Date(rownames(america2)), america2$MA_50, col = 'red', lwd = 2)

# The 50-day moving average starts off lower than the stock. The moving average goes above the stock
# price around february of 2020. The average then dips below the stock price around may of 2020 and stays
# below the stock price until around september of 2020, where it briefly goes above the stock price
# before dipping back below through the end of 2020.










