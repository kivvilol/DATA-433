# importing quantmod
library(quantmod)

# importing stock data
wellsfargo = getSymbols('WFC', from = '2020-10-01', to = '2020-12-31', auto.assign = F)
america = getSymbols('BAC', from = '2020-10-01', to = '2020-12-31', auto.assign = F)

# constructing a portfolio
portfolio = data.frame(wellsfargo$WFC.Adjusted, america$BAC.Adjusted)

# computing total returns
portfolio$WFC_tot_return = as.numeric(Delt(portfolio$WFC.Adjusted))
portfolio$BAC_tot_return = as.numeric(Delt(portfolio$BAC.Adjusted))

# computing gross returns
portfolio$WFC_gross_return = 1 + portfolio$WFC_tot_return
portfolio$BAC_gross_return = 1 + portfolio$BAC_tot_return

# removing NA
portfolio = na.omit(portfolio)

# computing cumulative returns
portfolio$WFC_cum_return = cumprod(portfolio$WFC_gross_return)
portfolio$BAC_cum_return = cumprod(portfolio$BAC_gross_return)

# computing w * r with 30-70 ratio
portfolio$WFC_index = (3/10) * portfolio$WFC_cum_return
portfolio$BAC_index = (7/10) * portfolio$BAC_cum_return

# computing portfolio value
portfolio$value = portfolio$WFC_index + portfolio$BAC_index

# The value of the portfolio on December 30, 2020 is 1.25. This means we have made a 125% increase on 
# our initial investment.

# computing w * r with equal weight
portfolio$WFC_index2 = (1/2) * portfolio$WFC_cum_return
portfolio$BAC_index2 = (1/2) * portfolio$BAC_cum_return

# portfolio value with equal weights
portfolio$value_equal = portfolio$WFC_index2 + portfolio$BAC_index2

# The value of the portfolio on December 30, 2020 is 1.26. This means we have made a 126% increase on 
# our initial investment.

# The strategy that performs the best is the equal value weighted portfolio.