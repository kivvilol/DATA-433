# importing quantmod
library(quantmod)

# importing ebay and paypal stock data
ebay = getSymbols('EBAY', from = '2020-01-01', to = '2020-12-31', auto.assign = F)
paypal = getSymbols('PYPL', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

# computing log(high/close)
ebay$log_high_close = log(ebay$EBAY.High / ebay$EBAY.Close)
paypal$log_high_close = log(paypal$EBAY.High / paypal$PYPL.Close)

# computing log(high/open)
ebay$log_high_open = log(ebay$EBAY.High / ebay$EBAY.Open)
paypal$log_high_open = log(paypal$PYPL.High / paypal$PYPL.Open)

# computing log(low/close)
ebay$log_high_close = log(ebay$EBAY.Low / ebay$EBAY.Close)
paypal$log_high_close = log(paypal$PYPL.Low / paypal$PYPL.Close)

# computing log(low/open)
ebay$log_low_open = log(ebay$EBAY.Low / ebay$EBAY.Open)
paypal$log_low_open = log(paypal$PYPL.Low / paypal$PYPL.Open)

# computing RSY measure
RSY_ebay = sqrt((1/nrow(ebay)*sum(ebay$log_high_close*ebay$log_high_open + ebay$log_low_close*ebay$log_low_open)))
RSY_paypal = sqrt((1/nrow(paypal)*sum(paypal$log_high_close*paypal$log_high_open + paypal$log_low_close*paypal$log_low_open)))

# Paypal has a higher RSY, so it is more volatile.