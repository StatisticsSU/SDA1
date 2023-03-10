# Two paired samples: online and local insurance premiums for 10 customer profiles.
# Author: Mattias Villani, https://mattiasvillani.com

library(mosaic)
library(openxlsx)
insurance <- read.xlsx('data/Chapter_21.xlsx', sheet = "Online_insurance")

# Alternative 1 - do just a standard one-population test on the difference variable
t.test(insurance$PriceDiff)


# Alternative 2 - make a new data frame with all observations as rows and a new
# variable place that records if the price was online or local.
df = data.frame(price = c(insurance$Local,insurance$Online), 
                place = c(rep("local", 10), rep("online", 10)))

# confidence interval for mu1-mu2 and paired t-test
t.test(price ~ place, data = df, paired = TRUE)


