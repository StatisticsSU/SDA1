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

ttest_results = t.test(~ Total.Pesticides |  Location, data = salmonTwoPop)

# Standard error for xBar1 - xBar2
SE = sqrt(s1^2/n1 + s2^2/n2)

# 95% Confidence interval for mu1-mu2
CI95 = c((xBar1 - xBar2) - tcrit*SE, xBar + tcrit*SE)

# 95% Confidence interval with the Mosaic package
with(salmon, t.test(Total.Pesticides[Location == "Eastern Canada"]))

# 68% Confidence interval with the Mosaic package
with(salmon, t.test(Total.Pesticides[Location == "Eastern Canada"], conf.level = 0.68))

# 99% Confidence interval with the Mosaic package
with(salmon, t.test(Total.Pesticides[Location == "Eastern Canada"], conf.level = 0.99))


#################################
# Let's analyze all locations now
#################################

locations = unique(salmon$Location) # Vector with names of the eight unique locations
n_locations = length(locations)     # Number of locations
# Preparing a table (matrix) with zeros to store results
summary_results = as.data.frame(matrix(rep(0,4*n_locations), n_locations, 4))
colnames(summary_results) <- c("Location", "SampleMean", "Lower95", "Upper95") # just column names
summary_results[,1] <- locations  # name the rows by the location name
for (i in 1:n_locations){
  results = with(salmon, t.test(Total.Pesticides[Location == locations[i]]))
  summary_results[i, 1] = locations[i]
  summary_results[i, 2] = as.numeric(results$estimate)
  summary_results[i, c(3,4)] = as.numeric(results$conf.int)
}
summary_results


# Plot the results with ggplot2 (tidyverse) 
library(ggplot2)
ggplot(summary_results) +
  geom_bar( aes(x = Location, y = SampleMean), stat = "identity", fill = "steelblue", alpha=0.7) +                      # bar chart
  geom_errorbar( aes(x = Location, ymin = Lower95, ymax = Upper95), width=0.5, colour="orange", alpha=0.9, cex = 0.5) + # adds the confidence intervals
  coord_flip() +                                                                                                        # flips coordinates so bars are horizontal
  theme(panel.grid.major.y = element_blank())                                                                           # removes the horizontal gridlines 



