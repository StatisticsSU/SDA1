###############################
# Jämföra två oberoende grupper
###############################

library(mosaic)

salmon <- read.csv(file = "data/Farmed_salmon.txt", sep = "\t")

salmonTwoPop <- salmon[salmon$Location == "Eastern Canada" | salmon$Location == "Norway", c(2,12)]
salmonTwoPop

t.test(Total.Pesticides ~ Location, data = salmonTwoPop)

# Alternativt sätt
t.test(~ Total.Pesticides |  Location, data = salmonTwoPop) # alternative formulation

###############################
# Jämföra två grupper - parade observationer
###############################

library(openxlsx)
insurance <- read.xlsx('data/Chapter_21.xlsx', sheet = "Online_insurance")
insurance

# Alternative 1 - do just a standard one-population test on the difference variable
t.test(insurance$PriceDiff)


# Alternative 2 - make a new data frame with all observations as rows and a new
# variable place that records if the price was online or local.
df = data.frame(price = c(insurance$Local,insurance$Online),
                place = c(rep("local", 10), rep("online", 10)))
df

# confidence interval for mu1-mu2 and paired t-test
t.test(price ~ place, data = df, paired = TRUE)


