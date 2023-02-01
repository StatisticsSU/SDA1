## Geometric distribution in R
## by Mattias Villani, https://mattiasvillani.com

library(mosaic)

# Geometric distribution with p = 0.4
p = 0.4

# Simulate n = 1000 random numbers from 
y = rgeom(1000, prob = p) # simulate
x = y + 1 # Adding one since R counts the number of failures BEFORE first success
mean(x) # mean of the simulations, should be close to E(X) = 1/p

# Compute probability P(X = 3)
dgeom(3, prob = p)

# Compute probability P(X <= 3)
pgeom(3, prob = p)

# Compute 90% quantile 
qgeom(0.9, prob = p)

# Plot the true distribution (probabilities) as red dots 
# Plot the simulated distribution as steelblue bars
probabilities = data.frame(x = 1:15, y = dgeom(0:14, prob = p)) # Mosaic wants a dataframe
bargraph(~x, data = as.data.frame(x), type = "proportion", c = "steelblue")
plotPoints(y ~ x, data =  probabilities, add = T, col = "red", pch = 19) # pch = 19 gives solid dots
