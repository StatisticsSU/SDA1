# Kod som simulerar en massa stickprov från en normalpopulation N(mu, sigma) och undersöker
# om skattningarna av mu och sigma är väntevärdesriktiga
# Vi är speciellt intresserade av att visa att division av n-1 och inte n i skattningen
# av standardavvikelsen ger väntevärdesriktig skattning av sigma.

# Först bestämmer vi populationsparametrarna mu och sigma och antal observation i varje stickprov
n = 10   # stickprovsstorlek
nRep = 1000  # antal simulerade datamaterial för samplingfördelningen
mu = 1
sigma = 2

# Vi vill spara skattningarna för varje datamaterial, så vi skapar lite vektorer
# nollor för att sedan skriva över nollorna med skattningar.
mu_est = rep(0, nRep)    # vektor för att spara sigma skattning för olika datamaterial
sigma_est = rep(0, nRep) # vektor för att spara sigma skattning för olika datamaterial
sigma_est_alt = rep(0, nRep) # vektor för att spara alternativ sigma skattning för olika datamaterial

# definierar alternativ estimator som delar med n istället för n-1
sd_alt <- function(x){ 
  n = length(x)
  return(sqrt(var(x)*((n-1)/n)))
}

# Ok, nu loopar vi för att skapa en massa stickprov av storlek n.
# För varje stickprov beräkningar vi skattningar och sparar resultaten.
for (i in 1:nRep){
  message(paste("stickprov nummer", i))
  x = rnorm(n, mean = mu, sd = sigma) # simulerat datamaterial
  mu_est[i] = mean(x)
  sigma_est[i] = sd(x)
  sigma_est_alt[i] = sd_alt(x)
}

# Kolla hur nära vi kommer i genomsnitt över alla stickprov
message(paste("Skattningen x_bar för parametern mu =",mu,"är i genomsnitt", mean(mu_est)))
message(paste("Standardavvikelseskattningen som delar med n-1 för parametern sigma =",sigma,"är i genomsnitt", mean(sigma_est)))
message(paste("Standardavvikelseskattningen som delar med n för parametern sigma =",sigma,"är i genomsnitt", mean(sigma_est_alt)))

# mu
mu_cumsum = cumsum(mu_est)/1:nRep
plot(mu_cumsum, type = "l", col = "steelblue", 
     ylim = c(min(mu_cumsum, mu), max(mu_cumsum, mu)),
     xlab = "stickprovsnummer", ylab = "mu", main = paste("n =", n))
abline(a = mu, b =  0, col = "orange")
legend("topright", legend = c("mu", "medelvärde"),
       col = c("orange", "steelblue"), lty = 1, cex = 0.8)


# sigmaskattningar
sigma_cumsum = cumsum(sigma_est)/1:nRep
sigma_alt_cumsum = cumsum(sigma_est_alt)/1:nRep
plot(cumsum(sigma_est)/1:nRep, type = "l", col = "steelblue", 
     ylim = c(min(sigma_cumsum, sigma_alt_cumsum, sigma), 
              max(sigma_cumsum, sigma_alt_cumsum, sigma)),
     xlab = "stickprovsnummer", ylab = "sigma", main = paste("n =", n))

lines(cumsum(sigma_est_alt)/1:nRep, col = "indianred")
abline(a = sigma, b =  0, col = "orange")
legend("topright", legend = c("sigma", "s", "s_alt"),
       col = c("orange", "steelblue", "indianred"), lty = 1, cex = 0.8)

