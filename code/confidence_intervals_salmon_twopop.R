# Confidence intervals for the Farmed_salmon data in the SDA-book, chapter 17.
# Two populations: Eastern Canada and Norway
# Author: Mattias Villani, https://mattiasvillani.com

library(mosaic)
salmon <- read.csv(file = "data/Farmed_salmon.txt", sep = "\t")
salmonTwoPop <- salmon[salmon$Location == "Eastern Canada" | salmon$Location == "Norway",]

x1 = salmon[salmon$Location == "Eastern Canada",]$Total.Pesticides 
n1 = length(x1)
x2 = salmon[salmon$Location == "Norway",]$Total.Pesticides 
n2 = length(x2)

# Plot the data - to check for normality
hist(x1, main = "Eastern Canada", xlab ="Bekämpningsmedel", c = alpha("orange", 0.7)) # Hard to tell with only 24 observations
bwplot(x1, main = "Eastern Canada", xlab ="Bekämpningsmedel", box.ratio = 0.2, fill = alpha("steelblue", 0.7), alpha = 0.5) # At least no outliers
hist(x2, main = "Norway", xlab ="Bekämpningsmedel", c = alpha("orange", 0.7)) # Hard to tell with only 24 observations
bwplot(x2, main = "Norway", xlab ="Bekämpningsmedel", box.ratio = 0.2, fill = alpha("steelblue", 0.7), alpha = 0.5) # At least no outliers

# Estimate the mean mu of the two population with the sample mean, xBar:
xBar1 = mean(x1)
xBar2 = mean(x2)

# Estimate the standard deviation of the populations:
s1 = sd(x1)
s2 = sd(x2)

# Using the t.test function to compute C.I. and do test H0: mu1 = mu2
t.test(Total.Pesticides ~ Location, data = salmonTwoPop)

# t.test(~ Total.Pesticides |  Location, data = salmonTwoPop) # alternative formulation

# since p-value = 0.02663 < 0.05, we reject H0 at 5% significance level

# Doing the confidence interval calculation "by hand"
SE = sqrt(s1^2/n1 + s2^2/n2) # Standard error for xBar1 - xBar2

# 95% Confidence interval for mu1-mu2
tcrit = qt(0.975, df = 17.223)  # df from results of t.test above
CI95 = c((xBar1 - xBar2) - tcrit*SE, (xBar1 - xBar2) + tcrit*SE)


