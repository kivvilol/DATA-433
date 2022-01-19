# importing quantmod
library(quantmod)

# importing ebay stock data
ebay = getSymbols('EBAY', from = '2020-01-01', to = '2020-12-31', auto.assign = F)
paypal = getSymbols('PYPL', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

# computing total returns
returns = data.frame(EBAY_total_returns = as.numeric(Delt(ebay$EBAY.Adjusted)), PYPL_total_returns = as.numeric(Delt(paypal$PYPL.Adjusted)))
returns = na.omit(returns)

# computing portfolio returns
returns$portfolio_return = 0.35 * returns$EBAY_total_returns + 0.65 * returns$PYPL_total_returns

# computing average portfolio returns
mu = mean(returns$portfolio_return)

# computing portfolio standard deviation
sigma = sd(returns$portfolio_return)

# computing 5% gaussian VaR
VaR = -(mu + sigma * qnorm(0.05)) * 100000

# computing the 5% gaussian ES
ES = (mu + sigma * dnorm(qnorm(0.05))/0.05) * 100000

# There is a 5% chance that our portfolio (EBAY(35%) and Paypal(65%)) losses exceed VaR ($4,104).
# If the losses exceed the VaR, we expect $5,788 in losses on average.
