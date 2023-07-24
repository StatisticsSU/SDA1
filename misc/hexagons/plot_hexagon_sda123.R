# Make Hex stickers

library("hexSticker")
library(magick)
library(sysfonts)
library(tidyverse)
library(rsvg)

setwd('/home/mv/Dropbox/Teaching/SDA1/misc/hexagons/figs/')
figFolder = "/home/mv/Dropbox/Teaching/SDA1/misc/hexagons/figs/"
fonts_dataset = font_files()
font_add("Ubuntu", "Ubuntu-M.ttf")

#y = rt(200, df = 30)
#save(y, file = "boxplotdata.RData")
load(file = "boxplotdata.RData")
data <- data.frame(y = y)
boxplot_image <- ggplot(data, aes(x = "", y = y)) +
  geom_boxplot(fill = "steelblue", alpha = 0.8, width= 0.15) +
  scale_y_reverse() +
  coord_flip() +
  theme_void()

sticker(
  subplot = "sda123iconimage.svg",
  package = "SDA",
  filename = "sda123icon.svg",
  s_width = 0.5, # figure options
  s_height = 1.4,
  s_x = 1,
  s_y = 0.65,
  h_fill = '#4C5D70',
  h_color = '#AEB8C4',
  h_size = 3,
  #url = "mattiasvillani.com",
  #u_size = 28,
  #u_color = 'white',
  spotlight = TRUE,
  l_y = 1,
  l_x = 0.3,
  l_width = 3,
  l_height = 3,
  l_alpha = 0.3,
  p_color = '#AEB8C4',
  p_family = "Ubuntu",
  p_size = 128,
  p_y = 1.35,
  p_x = 1
) %>% print()
