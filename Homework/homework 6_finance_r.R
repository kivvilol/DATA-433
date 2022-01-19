# importing quantmod
library(quantmod)

# importing ebay stock data
wellsfargo = getSymbols('WFC', from = '2018-01-01', to = '2020-12-31', auto.assign = F)
america = getSymbols('BAC', from = '2018-01-01', to = '2020-12-31', auto.assign = F)

# computing log(h_t / l_t)
wellsfargo$log_high_low = log(wellsfargo$WFC.High / wellsfargo$WFC.Low)
america$log_high_low = log(america$BAC.High / america$BAC.Low)

# computing the log-square
wellsfargo$log_square = wellsfargo$log_high_low^2
america$log_square = america$log_high_low^2

# computing the sum of log-squares
wellsfargo_log_sum = sum(wellsfargo$log_square)
america_log_sum = sum(america$log_square)

# computing Parkinson volatility
wellsfargo_parkinson = (1/(4*nrow(wellsfargo)*log(2))) * wellsfargo_log_sum
america_parkinson = (1/(4*nrow(america)*log(2))) * america_log_sum

## The stock with the highest Parkinson measure is Wells Fargo

# computing log(c_t / o_t)
wellsfargo$log_close_open = log(wellsfargo$WFC.Close / wellsfargo$WFC.Open)
america$log_close_open = log(america$BAC.Close / america$BAC.Open)

# computing square of log(c_t / o_t)
wellsfargo$log_close_open_square = wellsfargo$log_close_open^2
america$log_close_open_square = america$log_close_open^2

# Computing Garman-Klass volatility
gk_wellsfargo = sqrt(1/(2*nrow(wellsfargo) * sum(wellsfargo$log_square) - 
                          ((2*log(2) - 1)/nrow(wellsfargo)*wellsfargo$log_close_open_square)))

gk_america = sqrt(1/(2*nrow(america) * sum(america$log_square) - 
                          ((2*log(2) - 1)/nrow(america)*america$log_close_open_square)))

## Based on the Garman Klass volatility measure, wells fargo is more volatile.


# computing log(high/close)
wellsfargo$log_high_close = log(wellsfargo$WFC.High / wellsfargo$WFC.Close)
america$log_high_close = log(america$BAC.High / america$BAC.Close)

# computing log(high/open)
wellsfargo$log_high_open = log(wellsfargo$WFC.High / wellsfargo$WFC.Open)
america$log_high_open = log(america$BAC.High / america$BAC.Open)

# computing log(low/close)
wellsfargo$log_low_close = log(wellsfargo$WFC.Low / wellsfargo$WFC.Close)
america$log_low_close = log(america$BAC.Low / america$BAC.Close)

# computing log(low/open)
wellsfargo$log_low_open = log(wellsfargo$WFC.Low / wellsfargo$WFC.Open)
america$log_low_open = log(america$BAC.Low / america$BAC.Open)

# Computing RSY volatility
RSY_wellsfargo = sqrt((1/nrow(wellsfargo)*sum(wellsfargo$log_high_close *
                                                wellsfargo$log_high_open + 
                                                wellsfargo$log_low_close *
                                                wellsfargo$log_low_open)))

RSY_america = sqrt((1/nrow(america)*sum(america$log_high_close *
                                                america$log_high_open + 
                                                america$log_low_close *
                                                america$log_low_open)))

## Wells Fargo has a higher RSY, so it is more volatile.

## Based on all three volatility measures, Wells Fargo is the most volatile
## because it has the highest volatility measure using all three methods.