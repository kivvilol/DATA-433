# importing quantmod
library(quantmod)

# importing ebay and paypal stock data
ebay = getSymbols('EBAY', from = '2020-01-01', to = '2020-12-31', auto.assign = F)
paypal = getSymbols('PYPL', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

# computing log(h_t / l_t)
ebay$log_high_low = log(ebay$EBAY.High / ebay$EBAY.Low)
paypal$log_high_low = log(paypal$PYPL.High / paypal$PYPL.Low)

# computing the log-square
ebay$log_square = ebay$log_high_low^2
paypal$log_square = paypal$log_high_low^2

# computing the sum of log-squares
ebay_log_sum = sum(ebay$log_square)
paypal_log_sum = sum(paypal$log_square)

# computing parkinson volatility
ebay_Parkinson = (1/(4*nrow(ebay)*log(2))) * ebay_log_sum
paypal_Parkinson = (1/(4*nrow(paypal)*log(2))) * paypal_log_sum

# The paypal Parkinson volatility measure is higher, so the stock is more volatile.