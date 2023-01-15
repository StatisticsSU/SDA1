# Make Hex stickers

library("hexSticker")
library(magick)
library(sysfonts)
library(tidyverse)
library(rsvg)
library(ggmosaic)

setwd('/home/mv/Dropbox/Teaching/SDA1/misc/hexagons/figs/')
figFolder = "/home/mv/Dropbox/Teaching/SDA1/misc/hexagons/figs/"
#fonts_dataset = font_files()
font_add_google("Yellowtail", "Yellowtail")

img = image_read_svg("/home/mv/Dropbox/Teaching/SDA1/slides/figs/flaticons/computerdollar.svg")

sticker(
  subplot = img,#image_logo,
  package = "base-R",
  filename = "base_r_hexagon.svg",
  s_width = 0.85, # figure options
  s_height = 0.85,
  s_x = 1,
  s_y = 1.25,
  h_fill = '#6d6875',
  h_color = '#edede9',
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
  p_color = '#edede9',
  p_family = "Yellowtail",
  p_size = 10,
  p_y = 0.6,
  p_x = 1
) %>% print()
