# importing quantmod
library(quantmod)

# importing stock data
wellsfargo = getSymbols('WFC', from = '2019-01-01', to = '2020-12-31', auto.assign = F)
america = getSymbols('BAC', from = '2019-01-01', to = '2020-12-31', auto.assign = F)

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

tail(portfolio)

# Bank of America = 1.261
# Wells Fargo = 0.686

# Based on the above cumulative return numbers, we can see that both stock were good investments. However
# Bank of America was better because they had a 126% cumulative return, whereas Wells Fargo only 
# had a 68.6% cumulative return.