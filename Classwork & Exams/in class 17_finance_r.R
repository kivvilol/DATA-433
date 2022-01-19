# importing quantmod
library(quantmod)

# importing ebay and paypal stock data
ebay = getSymbols('EBAY', from = '2020-01-01', to = '2020-12-31', auto.assign = F)
paypal = getSymbols('PYPL', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

# computing total returns
returns = data.frame(EBAY_total_returns = as.numeric(Delt(ebay$EBAY.Adjusted)), PYPL_total_returns = as.numeric(Delt(paypal$PYPL.Adjusted)))
returns = na.omit(returns)

# defining the weights
weights = data.frame(EBAY_weight = seq(0, 1, 0.01))
weights$PYPL_weight = 1 - weights$EBAY_weight

# computing the portfolio returns
weights$portfolio_returns = weights$EBAY_weight * mean(returns$EBAY_total_returns) + 
                            weights$PYPL_weight + mean(returns$PYPL_total_returns)

# computing the portfolio variance
var_ebay = var(returns$EBAY_total_returns)
var_paypal = var(returns$PYPL_total_returns)
cov_ebay_paypal = cov(returns$EBAY_total_returns, returns$PYPL_total_returns)

weights$portfolio_variance = weights$EBAY_weight^2 * var_ebay + 
                            weights$PYPL_weight * var_paypal + 2 * 
                            cov_ebay_paypal * weights$EBAY_weight * weights$PYPL_weight

# computing sharpe ratio
daily_risk_rate = 0.0008 / 365
weights$Sharpe_Ratio = (weights$portfolio_returns - daily_risk_rate) / sqrt(weights$portfolio_variance)

# selecting weights that maximize sharpe ratio
weights_max = weights[which.max(weights$Sharpe_Ratio), ]







