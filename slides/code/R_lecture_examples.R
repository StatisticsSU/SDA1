###########################################################
# Code for Föreläsning 2: Kort introduktion till R
###########################################################
rm(list = ls()) # Clears the workspace
graphics.off() # Clears the plots
cat("\014") # Clears the console
library(mosaic) # For plots
library("RColorBrewer") # For nice color scheme
cs = brewer.pal(5, "Paired") # Nice colors
# Set the path (change for your own)
setwd('C:/Users/quiroz/Dropbox/Teaching/Stockholm University/SDA1/R code lectures/')
###########################################################
# Example 1: Smartphone brand preferences
###########################################################
load(file = "Datasets/SmartPhones.RData") # Load data
head(SmartPhones) # Inspect first rows

# Tables summarising counts, proportions, and percentages, per outcome (brand, age_group)
tally(~ brand + age.group, data = SmartPhones)
tally(~ brand + age.group, data = SmartPhones, format = "proportion") # Same put fractions
tally(~ brand + age.group, data = SmartPhones, format = "percent") # Same put percentage

# Show the totals for each variable 
tally(~ brand + age.group, data = SmartPhones, margins = TRUE)

# Tables summarising brand percentages given age.group
tally(~ brand | age.group, data = SmartPhones, format = "percent")
tally(~ brand | age.group, data = SmartPhones, format = "percent", margins = TRUE)

# Figure brand percentages per age.group
bargraph(~ brand | age.group, data = SmartPhones, type = "percent")

# Figure age.group percentages per brand
bargraph(~ age.group | brand, data = SmartPhones, type = "percent")

###########################################################
# Example 2: Diamonds
###########################################################
library(ggplot2) # Contains diamonds
# diamonds is a tibble dataframe and not a base R dataframe. 
# Tibble dataframes are more efficient to print and subset for large datasets.
# We transform it to a base R dataframe since we do not want to introduce too
# much new stuff at this stage. 
help("diamonds")
diamonds_data <- as.data.frame(diamonds)
str(diamonds_data)
head(diamonds_data)
# Histogram price
histogram(~ price, data = diamonds_data, type = 'count')
# Histogram per color group
histogram(~ price | color, data = diamonds_data, type = 'count')
# Boxplot price by color (covered in Föreläsning 4)
boxplot(price ~ color, data = diamonds_data, col = cs[1])
# Boxplot price vs clarity
boxplot(price ~ clarity, data = diamonds_data, col = cs[1])
# Plot price vs carat
plot(price ~ carat, data = diamonds_data, col = cs[1])
# Plot price vs length
plot(price ~ x, data = diamonds_data, col = cs[1])

###########################################################
# Example 3: Capital Asset Pricing Model (CAPM) 
###########################################################
load("Datasets/CAPM_data.RData")
str(CAPM)
head(CAPM)

# Market return
plot(MARKET ~ DATE, data = CAPM, type = "l", col = cs[1])
# risk-free asset return
plot(RKFREE ~ DATE, data = CAPM, type = "l", col = cs[1])

# Market and IBM
plot(MARKET ~ DATE, data = CAPM, type = "l", lwd = 2, col = cs[1], ylim = c(-0.3, 0.3))
lines(CAPM$DATE, CAPM$IBM,  lwd = 2, col = cs[3])
legend(x = "topright", lty = 1 , lwd = 2, col = c(cs[1], cs[3]), legend=c("Market", "IBM"))
# Market and IBM seem to follow each other. We say they are correlated (Föreläsning 7)
plot(IBM ~ MARKET, data = CAPM, col = cs[1])

# Is IBM a risky asset?
# Excess return IBM y_t = Return of asset - Return of a risk-free asset (e.g. a bond)
y <- CAPM$IBM - CAPM$RKFREE
# Excess return market x_t = Return of market - Return of a risk-free asset (e.g. a bond)
x <- CAPM$MARKET - CAPM$RKFREE
plot(y ~ x, data = CAPM, col = cs[1], ylab = "Excess return IBM", xlab = "Excess return market")
lm_IBM <- lm(y ~ x)
abline(lm_IBM, col = "red")
# What is the estimated slope beta? 
summary(lm(y ~ x))
# beta is 0.4568208 < 1. Changes in the market returns dampens changes in the IBM excess returns.

# Market and Tandy
plot(MARKET ~ DATE, data = CAPM, type = "l", lwd = 2, col = cs[1], ylim = c(-0.3, 0.5))
lines(CAPM$DATE, CAPM$TANDY,  lwd = 2, col = cs[5])
legend(x = "topright", lty = 1 , lwd = 2, col = c(cs[1], cs[5]), legend=c("Market", "Tandy"))

# Is Tandy a risky asset?
# Excess return Tandy y_t = Return of asset - Return of a risk-free asset (e.g. a bond)
y <- CAPM$TANDY - CAPM$RKFREE
# Excess return market x_t = Return of market - Return of a risk-free asset (e.g. a bond)
x <- CAPM$MARKET - CAPM$RKFREE
plot(y ~ x, data = CAPM, col = cs[1], ylab = "Excess return Tandy", xlab = "Excess return market")
lm_Tandy <- lm(y ~ x)
abline(lm_Tandy, col = "red")
# What is the estimated slope beta? 
summary(lm(y ~ x))
# beta is 1.050 > 1. Changes in the market returns amplify changes in the Tandy excess returns.

# Final exercise: Prediction
# Suppose the excesses return of the market is 0.05. Predict the excess return of IBM:
new_x <- data.frame(x = c(0.05))
print(predict(lm_IBM, newdata = new_x))