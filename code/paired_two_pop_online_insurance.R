# Confidence intervals for the Farmed_salmon data in the SDA-book, chapter 17.
# Two paired samples: online and local insurance premiums for 10 customer profiles.
# Author: Mattias Villani, https://mattiasvillani.com

library(mosaic)
library("openxlsx")
insurance <- read.xlsx('data/Chapter_21.xlsx', sheet = "Online_insurance")

df = data.frame(price = c(insurance$Local,insurance$Online), 
                place = c(rep("local", 10), rep("online", 10)))
df_for_box = data.frame(price = c(insurance$Local,insurance$Online, insurance$PriceDiff), place = c(rep("local", 10), rep("online", 10), rep("diff",10)))

# Plot the data - to check for normality
bwplot(price ~ place, data = df_for_box, main = "Insurance premiums", xlab ="Insurance premium", box.ratio = 0.2, fill = alpha("steelblue", 0.7), alpha = 0.5) # At least no outliers

# confidence interval for mu1-mu2 and paired t-test
t.test(price ~ place, data = df, paired = TRUE)


