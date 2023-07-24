suppressMessages(library(dplyr))
suppressMessages(library(kableExtra))
library(ggplot2)
library(RColorBrewer)
prettycol = RColorBrewer::brewer.pal(12, "Paired")[c(1,2,7,8,3,4,5,6,9,10,11,12)]

# Sannolikhetsfördelning
df = data.frame(x1 = c(0.1), x2 = c(0.25), x3 = (0.4), x4 = c(0.2), x5 = c(0.05))
options(scipen = 999)
df %>%
  kbl(format= "latex", align="rrr", col.names = as.factor(1:5), booktabs = T) %>%
  kable_styling(latex_options = c("striped", "scale_down")) %>%
  kable_classic(full_width = F, font_size = 14) %>%
  save_kable("slides/tables/probdist.tex")


# From fan chart Penningpolitisk rapport Nov 2022. Forecast interval for end of 2023. Eye-balling gives the forecast distribution
# N(2.9, 1.155^2) for repo rate. 
# Assumption your interest rate in bank is 1% higher.
amount = 1000000
additional_interest = 1
lower = -0.5:6.5;
prob_between_limits = pnorm(lower+1, mean = 2.9, sd = 1.1551) - pnorm(lower, mean = 2.9, sd = 1.1551)
prob_between_limits = round(prob_between_limits/sum(prob_between_limits), digits = 3)
df = data.frame(interest = lower + 0.5 + additional_interest,  prob = prob_between_limits)
df$interest_cost = round((df$interest/(12*100))*amount, digits = 0)
mean = sum(df$prob*df$interest_cost)
variance = sum(df$prob*(df$interest_cost-mean)^2)
stdev = sqrt(variance)
mean_interest = sum(df$prob*df$interest)

head(df)
options(scipen = 999)
df %>%
  format(digits = 4) %>%
  kbl(format= "latex", align="rrr", col.names = c("ränta i %", "sannolikhet","månadskostnad"), row.names = FALSE, booktabs = T) %>%
  kable_styling(latex_options = c("striped", "scale_down")) %>%
  kable_classic(full_width = F, font_size = 14) %>%
  save_kable("slides/tables/rantekostnad.tex")

# kostnad - bar chart
p<-ggplot(data = df, aes(x=interest_cost, y=prob)) +
  geom_bar(stat = "identity", fill = prettycol[4]) +
  geom_vline(xintercept = mean, col = prettycol[2], lwd = 1) + 
  xlab("räntekostnad i kr") +
  ylab("sannolikhet") +
  ggtitle(paste0("Väntevärde = ",(mean))) +
  theme(text = element_text(size = 20),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"))
ggsave("slides/figs/rantekostnad.pdf", width = 5, height = 5) 
p 

# ranta - bar chart
p<-ggplot(data = df, aes(x=interest, y=prob)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_vline(xintercept = mean_interest, col = prettycol[4], lwd = 1) + 
  xlab("ränta i %") +
  ylab("sannolikhet") +
  ggtitle(paste0("Väntevärde = ",(mean_interest))) +
  theme(text = element_text(size = 20),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"))
ggsave("slides/figs/ranta.pdf", width = 5, height = 5) 
p 


# Triss
library(sda123)
head(triss)
df = triss
df = rbind(c(0,6000000-1287000,0.7855), df)
options(scipen = 999)
df %>%
  format(digits = 4) %>%
  kbl(format= "latex", align="rrr", col.names = names(df), row.names = FALSE, booktabs = T) %>%
  kable_styling(latex_options = c("striped", "scale_down")) %>%
  kable_classic(full_width = F, font_size = 14) %>%
  save_kable("slides/tables/triss.tex")


# antal
p<-ggplot(data = df, aes(x=as.factor(vinst), y=antal)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  scale_y_log10() +
  xlab("vinstbelopp") +
  ylab("antal lotter (log skala)") +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"))
ggsave("slides/figs/triss_antal.pdf", width = 5, height = 5) 
p 

options(scipen = 999)
p<-ggplot(data = df, aes(x=as.factor(vinst), y=probs)) +
  geom_bar(stat = "identity", fill = prettycol[4]) +
  #scale_y_log10() +
  xlab("vinstbelopp") +
  ylab("sannolikhet") +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"))
ggsave("slides/figs/triss_probs.pdf", width = 5, height = 5) 
p 

c(sum(df$probs[df$vinst >=10000]), sum(df$probs[df$vinst >=100000]), sum(df$probs[df$vinst >=1000000]))


