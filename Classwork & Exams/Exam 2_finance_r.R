library(quantmod)
library(quadprog)

# importing stock data
alibaba = getSymbols('BABA', from = '2018-01-01', to = '2021-01-31', auto.assign = F)
cbs = getSymbols('VIAC', from = '2018-01-01', to = '2021-01-31', auto.assign = F)
goldman = getSymbols('GS', from = '2018-01-01', to = '2021-01-31', auto.assign = F)
disney = getSymbols('DIS', from = '2018-01-01', to = '2021-01-31', auto.assign = F)
paypal = getSymbols('PYPL', from = '2018-01-01', to = '2021-01-31', auto.assign = F)

# computing total returns
returns = data.frame(BABA_total_returns = as.numeric(Delt(alibaba$BABA.Adjusted)), 
                     VIAC_total_returns = as.numeric(Delt(cbs$VIAC.Adjusted)), 
                     GS_total_returns = as.numeric(Delt(goldman$GS.Adjusted)), 
                     DIS_total_returns = as.numeric(Delt(disney$DIS.Adjusted)),
                     PYPL_total_returns = as.numeric(Delt(paypal$PYPL.Adjusted)))
returns = na.omit(returns)

## MINIMIZING PORTFOLIO VARIANCE
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

## Our stock weights are as follows: (values are rounded for written answer purposes)
## Alibaba = ~33.1%, CBS = ~4.65%, Goldman = ~12.9%, Disney = ~38%, Paypal = ~11.4%


## MAXIMIZING SHARPE RATIO
# defining risk free rate
daily_risk = 0.0008 / 365

# defining the matrix of constraints
return_means = colMeans(returns) - daily_risk
A2 = rbind(return_means, diag(n))

# solving optimization problem
weights_max_Sharpe = solve.QP(Dmat = D, dvec = dvec, Amat = t(A2), bvec = b0, meq = 1)$solution
weights_max_Sharpe = weights_max_Sharpe/sum(weights_max_Sharpe)

## To maximize our portfolio, we need to put 100% of our stock into Alibaba.







