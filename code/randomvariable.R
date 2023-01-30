suppressMessages(library(dplyr))
suppressMessages(library(kableExtra))
library(ggplot2)
library(RColorBrewer)
prettycol = RColorBrewer::brewer.pal(12, "Paired")[c(1,2,7,8,3,4,5,6,9,10,11,12)]

# Triss
library(sda1)
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


