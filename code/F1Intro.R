
# Network adjacency matrix
suppressMessages(library(dplyr))
suppressMessages(library(kableExtra))
oddCellCol = "#F0F0F0"
Adj = matrix(c(0,	0	, 0,	0,	0,	1,
               0,	0,	1	,0,	1,	0,
               0,	1	, 0,	1,	0,	1,
               0,	0	, 1,	0,	0,	1,
               0,	0,	0,	0,	0,	1,
               0,	0	,0,	0	,0,	0), 6, 6, byrow = T) %>%
  format(digits = 4) %>%
  data.frame()
namesgraph = c("Julia  ",	"   Per    ",	"Antonio",	"Quentin",	"Groucho", 	"Maria  ")
names(Adj) <- namesgraph
rownames(Adj) <- namesgraph

Adj %>%
  kbl(format = "html", align="r", table.attr = "style='width:30%;'") %>%
  kable_paper(full_width = F, font_size = 14) %>%
  row_spec(seq(2, dim(Adj)[1], by = 2), background = oddCellCol) %>%
  kable_styling(bootstrap_options = c("condensed"))

