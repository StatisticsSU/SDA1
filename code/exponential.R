## Exponential distribution in R
## by Mattias Villani, https://mattiasvillani.com

library(mosaic)

# Exponential distribution with lambda = 3
lambda = 3

# Simulate n = 10000 random numbers from 
n = 10000
x = rexp(n, rate = lambda) # simulate
mean(x) # mean of the simulations, should be close to E(X) = 1/lambda = 1/3

# Compute probability function at x = 0.5
dexp(0.5, rate = lambda)

# Compute probability P(X <= 0.5)
pexp(0.5, rate = lambda)

# Compute 90% quantile 
qexp(0.9, rate = lambda)

# Let's check that mean of the simulated values becomes closer to true E(X) = 1/lambda 
# as we add more and more simulated values from our n = 10000 values.
plot(cumsum(x)/1:n, type = "l", ylab = "mean of simulations", xlab = "number of simulated values")
abline(a = 1/lambda, b = 0, col = "red")
legend("topleft", inset=.01, legend=c("mean", "E(X)=1/lambda"),
       col=c("black", "red"), lty = c(1,1), cex=1)

# Plot the true probability distribution as dark blue line 
# and the simulated distribution as a histogram with lighter blue bars
xvalues = seq(0,5, by = 0.01)
probabilities = data.frame(x = xvalues, y = dexp(xvalues, rate = lambda)) # Mosaic wants a dataframe

hist(x, 50, freq = F, col = "cornflowerblue")
lines(probabilities$x, probabilities$y, type = "l", lwd = 3, col = "darkblue", 
      xlab = "x", ylab = "Sannolikhetsfunktion, f(x)", main = "Sannolikhetsfunktion för Expon(3)")
