install.packages("kableExtra")
library(dplyr)
library(kableExtra)

latex_path = '/home/mv/Dropbox/Apps/ShareLaTeX/SDA1/tables/'

# Z-fördelningen

Ztable = matrix(pnorm(seq(0, 3.99, by = 0.01)), length(seq(0, 3.99, by = 0.1)), 10, byrow = T) %>%
  format(digits = 4) %>%
  data.frame()
names(Ztable) <- as.character(format(seq(0.00, 0.09, by = 0.01), digits = 3))
rownames(Ztable) <- as.character(format(seq(0.0, 3.9, by = 0.1), digits = 2))

Ztable %>%
  kbl(format= "html",
      align="r") %>%
  kable_classic(full_width = F, html_font = "helvetica")


%>%
  save_kable(paste(latex_path,"Ztabell.tex"), float = FALSE)
