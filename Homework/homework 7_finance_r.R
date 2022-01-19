library(quantmod)
library(quadprog)

# importing stock data
paypal = getSymbols('PYPL', from = '2018-01-01', to = '2021-01-31', auto.assign = F)
alibaba = getSymbols('BABA', from = '2018-01-01', to = '2021-01-31', auto.assign = F)
intel = getSymbols('INTC', from = '2018-01-01', to = '2021-01-31', auto.assign = F)
jpmorgan = getSymbols('JPM', from = '2018-01-01', to = '2021-01-31', auto.assign = F)

returns = data.frame(PYPL_total_returns = as.numeric(Delt(paypal$PYPL.Adjusted)), 
                     BABA_total_returns = as.numeric(Delt(alibaba$BABA.Adjusted)), 
                     INTC_total_returns = as.numeric(Delt(intel$INTC.Adjusted)), 
                     JPM_total_returns = as.numeric(Delt(jpmorgan$JPM.Adjusted)))
returns = na.omit(returns)

# MINIMIZING PORTFOLIO VARIANCE
# defining number of stocks
n = dim(returns)[2]

# defining dvec
dvec = rep(0, n)

# defining covariance matrix
D = cov(returns)

# defining the matrix of constraints
A = rbind(rep(1, n), diag(n))
b0 = c(1, rep(0,n))

weights_min_var = solve.QP(Dmat = D, dvec = dvec, Amat = t(A), bvec = b0, meq = 1)$solution

## The stock with the higher weight is JP Morgan at 39%. The stock with the lower weight is
## Intel with just over 9%.

# MAXIMIZING SHARPE RATIO

# defining risk free rate
daily_risk = 0.0008 / 365

# defining the matrix of constraints
return_means = colMeans(returns) - daily_risk
A2 = rbind(return_means, diag(n))

# solving optimization problem
weights_max_Sharpe = solve.QP(Dmat = D, dvec = dvec, Amat = t(A2), bvec = b0, meq = 1)$solution
weights_max_Sharpe = weights_max_Sharpe/sum(weights_max_Sharpe)

## Paypal has the highest weight, and alibaba has the lowest weight. We need to put 100% of our
## money into paypal and 0% into the other stocks to maximize our sharpe ratio problem.


