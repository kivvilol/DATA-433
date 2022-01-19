# importing quantmod
library(quantmod)

# importing stock data
wellsfargo = getSymbols('WFC', from = '2019-10-01', to = '2020-12-31', auto.assign = F)
america = getSymbols('BAC', from = '2019-10-01', to = '2020-12-31', auto.assign = F)

# computing total returns
returns = data.frame(WFC_total_return = as.numeric(Delt(wellsfargo$WFC.Adjusted)), BAC_total_return = as.numeric(Delt(america$BAC.Adjusted)))
returns = na.omit(returns)

# computing portfolio returns
returns$portfolio_return = 0.35 * returns$WFC_total_return + 0.65 * returns$BAC_total_return

# calculating portfolio average and standard deviation
mu = mean(returns$portfolio_return)
sigma = sd(returns$portfolio_return)

# computing Gaussian VaR (5%)
VaR = -(mu + sigma*qnorm(0.05))*100000
