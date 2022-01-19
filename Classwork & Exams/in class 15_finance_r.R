# importing quantmod
library(quantmod)

# importing ebay and paypal stock data
ebay = getSymbols('EBAY', from = '2020-01-01', to = '2020-12-31', auto.assign = F)
paypal = getSymbols('PYPL', from = '2020-01-01', to = '2020-12-31', auto.assign = F)
sp = getSymbols('^GSPC', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

# computing total returns
returns = data.frame(EBAY_total_returns = as.numeric(Delt(ebay$EBAY.Adjusted)), PYPL_total_returns = as.numeric(Delt(paypal$PYPL.Adjusted)), SP500_total_returns = as.numeric(Delt(sp$GSPC.Adjusted)))
returns = na.omit(returns)

# constructing the portfolio
returns$Portfolio_return = 0.4 * returns$EBAY_total_returns + 0.6 * returns$PYPL_total_returns


# Computing Roy ratio of portfolio
MAR = 0.0062 / 365
mu_portfolio = mean(returns$Portfolio_return)
sigma_portfolio = sd(returns$Portfolio_return)
Roy_portfolio = (mu_portfolio - MAR) / sigma_portfolio


# Computing Roy ratio of benchmark
mu_benchmark = mean(returns$SP500_total_returns)
sigma_benchmark = sd(returns$SP500_total_returns)
Roy_benchmark = (mu_benchmark - MAR) / sigma_benchmark

# The Roy ratio of the portfolio is higher, so it is a better strategy.