# Make Hex stickers

library("hexSticker")
library(magick)
library(sysfonts)
library(tidyverse)
library(rsvg)
library(ggmosaic)

setwd('/home/mv/Dropbox/Teaching/SDA1/misc/hexagons/figs/')
figFolder = "/home/mv/Dropbox/Teaching/SDA1/misc/hexagons/figs/"
fonts_dataset = font_files()
font_add("Ubuntu", "Ubuntu-M.ttf")

img <- flights %>% drop_na() %>%
  ggplot() +
  geom_mosaic(aes(x = product(reclining_obligation_to_behind, rude_to_recline), fill=reclining_obligation_to_behind), show.legend = F)  +
  scale_fill_brewer() +
  theme_void()

sticker(
  subplot = img,#image_logo,
  package = "mosaic",
  filename = "mosaic_hexagon.svg",
  s_width = 0.85, # figure options
  s_height = 0.85,
  s_x = 1,
  s_y = 1.18,
  h_fill = '#4C5D70',
  h_color = '#AEB8C4',
  h_size = 2,
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
  p_size = 10,
  p_y = 0.6,
  p_x = 1
) %>% print()
