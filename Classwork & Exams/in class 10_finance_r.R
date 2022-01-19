# loading quantmod
library(quantmod)

# downloading stock data
wellsfargo = getSymbols('WFC', from = '2020-10-01', to = '2020-12-31', auto.assign = F)
america = getSymbols('BAC', from = '2020-10-01', to = '2020-12-31', auto.assign = F)

# computing total returns
wellsfargo$total_return = as.numeric(Delt(wellsfargo$WFC.Adjusted))
america$total_return = as.numeric(Delt(america$BAC.Adjusted))

# creating returns data frame
returns = data.frame(wellsfargo$total_return, america$total_return)
returns = na.omit(returns)

# computing covariance
returns_cov = cov(returns)

# defining weights
w = c(0.35, 0.65)

# computing portfolio variance using matrix algebra
portfolio_var = t(w) %*% returns_cov %*% w
portfolio_var