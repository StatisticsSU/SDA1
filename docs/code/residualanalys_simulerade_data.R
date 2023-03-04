# Troubles in paradise?
# Simulate from models where the standard assumptions for regression do not hold
# and see if residual analysis detects the issues

#install.packages("remotes")
#library(remotes)
#install_github("StatisticsSU/sda1paket")
library(sda1)

# Simulate regression with homoscedastic normal errors
simdata <- reg_simulate(n = 100, betavect = c(1, 1, -1), sigma_eps = 1)
fit = lm(y ~ X1 + X2, data = simdata)
reg_residuals(fit)


# Simulate regression with heteroscedastic normal errors
heterofunc <- function(x){
  return(1*exp(x))
}
simdata <- reg_simulate(n = 100, betavect = c(1, 1, -1), responsedist = 'normal', sigma_eps = heterofunc, heteroparams = c(0, 1, 0))
fit = lm(y ~ X1 + X2, data = simdata)
reg_residuals(fit)

# Simulate regression with homoscedastic student-t with df 4 errors
simdata <- reg_simulate(n = 100, betavect = c(1, 1, -1), responsedist = 'student', sigma_eps = 1, studentdf = 4)
fit = lm(y ~ X1 + X2, data = simdata)
reg_residuals(fit)

# Simulate regression with heteroscedastic student-t with df 4 errors
simdata <- reg_simulate(n = 100, betavect = c(1, 1, -1), responsedist = 'student', sigma_eps = heterofunc, heteroparams = c(0, 1, 0), studentdf = 4)
fit = lm(y ~ X1 + X2, data = simdata)
reg_residuals(fit)

# Simulate regression with heteroscedastic student-t with df 4 errors
simdata <- reg_simulate(n = 100, betavect = c(1, 1, -1), sigma_eps = 0)
simdata$y = simdata$y + simAR1(n =100, phi = 0.95, sigma_eps = 1*(1-0.95^2))
fit = lm(y ~ X1 + X2, data = simdata)
reg_residuals(fit)

