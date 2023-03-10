# Simulera från enkel regressionsmodell

# y = beta0 + beta1*x + epsilon, epsilon ~ N(0, sigma_epsilon)

# Hitta på en populationsmodell genom att bestämma modellens parametrar
beta0 = -1
beta1 = 1
sigma_epsilon = 0.1

# Simulera ett stickprov från populationsmodellen
n = 20
x = seq(-1, 1, length = n) # x-variabeln är inte slumpmässig

# Här simulerar vi en vektor med alla epsilon för x:n i stickprovet
epsilon = rnorm(n, mean = 0, sd = sigma_epsilon)
epsilon

# Sen lägger vi bara på dessa epsilon till regressionslinje för att få alla y i stickprovet.
y = beta0 + beta1*x + epsilon

# Plotta data och populations regressionslinje
regdata = data.frame(y = y, x = x)
head(regdata)
plot(y ~ x, data = regdata, xlim = c(-1,1))
abline(a = beta0, b = beta1, col = "orange", lwd = 2) # populationens regressionsline

# Skatta modellen från ett stickprov och plotta skattad regressionslinje
skattad_modell = lm(y ~ x, data = regdata)
summary(skattad_modell)
b0 = skattad_modell$coefficients[1]
b1 = skattad_modell$coefficients[2]
b0
b1
abline(a = b0, b = b1, col = "steelblue", lwd = 2) # skattad regressionsline

# residualerna, e,  är våra skattningar av modellens feltermer, epsilon.
e = skattad_modell$residuals # e = y - yhat
e
epsilon
plot(epsilon, e)
abline(a = 0, b = 1, col = "gray")
