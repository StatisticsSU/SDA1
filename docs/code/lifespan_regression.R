#install.packages("remotes")
#library(remotes)
#install_github("StatisticsSU/sda1paket")
library(sda1)

lifespan_no_usa = lifespan[1:29,] # ta bort outliern USA

######################
# ENKEL REGRESSION 
######################

# Först enkel regression med bara en förklarande variabel
model = lm(lifespan ~ spending, data = lifespan_no_usa) 
summary(model)

# Konfidensintervall - base R
model = lm(lifespan ~ spending, data = lifespan_no_usa) 
confint((model))

# Konfidensintervall - sda1
model = lm(lifespan ~ spending, data = lifespan_no_usa)
reg_summary(model, conf_intervals = TRUE, anova = FALSE)

# Prediktionsintervall - sda1
reg_predict(lifespan ~ spending, data = lifespan_no_usa)

# Prediktion med intervall för ett land som Sverige men med 1 tusen dollar per capita extra 

model = lm(lifespan ~ spending, data = lifespan_no_usa)
predict(model, newdata = data.frame(spending = 3.323))
predict(model, newdata = data.frame(spending = 4.323))
predict(model, newdata = data.frame(spending = 4.323), interval = "prediction")    



######################
# MULTIPEL REGRESSION 
######################

# Multipel regression med tre förklarande variabler

model = lm(lifespan ~ spending + gdp + doctorvisits, data = lifespan_no_usa) # utan USA
summary(model)

# Prediktion med intervall för ett land som Sverige men med 1 tusen dollar per capita extra 

lifespan[26,]
predict(model, newdata = data.frame(spending = 3.323, gdp = 40.90968, doctorvisits = 2.8))
predict(model, newdata = data.frame(spending = 4.323, gdp = 40.90968, doctorvisits = 2.8), 
        interval = "prediction")
