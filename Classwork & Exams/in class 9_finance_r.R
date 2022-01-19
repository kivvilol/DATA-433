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

# computing w * r
portfolio$WFC_index = (1/2) * portfolio$WFC_cum_return
portfolio$BAC_index = (1/2) * portfolio$BAC_cum_return

# computing portfolio value
portfolio$value = portfolio$WFC_index + portfolio$BAC_index


