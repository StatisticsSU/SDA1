suppressMessages(library(dplyr))
options(kableExtra.latex.load_packages = FALSE)
suppressMessages(library(kableExtra))
latex_path = "/home/mv/Dropbox/Apps/ShareLaTeX/SDA1/tables/"

# Chi2
dfs = c(1:30,40,50,60,70,80,90,100)
onetailedprobs = c(0.1, 0.05, 0.025, 0.01, 0.005)
Chi2table = matrix(NA, length(dfs), length(onetailedprobs))
count = 0
for (df in dfs){
  count = count + 1
  Chi2table[count, ] = qchisq(1 - onetailedprobs, df = df);
}
Chi2table = format(as.data.frame(Chi2table), digits = 4)
names(Chi2table) <- as.character(format(onetailedprobs, digits = 3))
rownames(Chi2table) <- as.character(format(dfs, digits = 1))

res = Chi2table %>%
  format(digits = 4) %>%
  kbl(format = "latex", booktabs = T, align = 'lrrrrr') %>%
  kable_styling(latex_options = c("striped"), font_size = 10) %>%
  save_kable(paste0(latex_path,"Chi2tabell.tex"))

