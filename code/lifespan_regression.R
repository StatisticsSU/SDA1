#install.packages("remotes")
#library(remotes)
#install_github("StatisticsSU/sda123")
library(sda123)

lifespan_no_usa = lifespan[1:29,] # ta bort outliern USA

################################
# ENKEL REGRESSION LIFESPAN 
################################

# Först enkel regression med bara en förklarande variabel
model = lm(lifespan ~ spending, data = lifespan_no_usa) 
summary(model)

# Konfidensintervall - base R
confint(model)

# Konfidensintervall - sda123
reg_summary(model, conf_intervals = TRUE, anova = FALSE)

# Residualanalys
model = lm(lifespan ~ spending, data = lifespan_no_usa)
reg_residuals(model)

# Prediktionsintervall - sda123
reg_predict(lifespan ~ spending, data = lifespan_no_usa)

# Anpassat värde/prediktion för Sverige:
lifespan[26,] # Titt på observationen Sverige
predict(model, newdata = data.frame(spending = 3.323))
# Prediktion för ett land som Sverige, men med 1 tusen dollar per capita extra i spending på sjukvård
predict(model, newdata = data.frame(spending = 4.323)) # så nästan 2 extra levnadsår med de pengarna
# Prediktion med intervall för ett land som Sverige, men med 1 tusen dollar per capita extra i spending på sjukvård
predict(model, newdata = data.frame(spending = 4.323), interval = "prediction")   # men det är rätt stor osäkerhet i prediktionen



################################
# MULTIPEL REGRESSION LIFESPAN
################################

# Multipel regression med tre förklarande variabler
model = lm(lifespan ~ spending + gdp + doctorvisits, data = lifespan_no_usa) # utan USA
summary(model)

# Prediktion med intervall för ett land som Sverige men med 1 tusen dollar per capita extra 
lifespan[26,]
predict(model, newdata = data.frame(spending = 4.323, gdp = 40.90968, doctorvisits = 2.8), 
        interval = "prediction")


