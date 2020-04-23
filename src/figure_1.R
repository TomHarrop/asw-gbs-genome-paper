#!/usr/bin/env Rscript

library(ggplot2)
library(ggmap)
library(cowplot)

f1a <- readRDS("fig/location_map.Rds")
f1b <- readRDS("fig/obs_het.Rds")
f1c <- readRDS("fig/pairwise_fst.Rds")
f1d <- readRDS("fig/pca2d.Rds")



lon_bump <- 0.25
lat_bump <- 0.025

row1 <- plot_grid(f1a + xlab("Longitude") + ylab("Latitude"),
          f1b,
          # align = "v",
          # axis = "tb",
          nrow = 1,
          rel_widths = c(10, 10),
          labels = c("A", "B"),
          label_size = 8,
          label_fontface = "bold")

row2 <- plot_grid(f1c + coord_fixed(),
                   f1d,
                   # align = "v",
                   # axis = "tb",
                   nrow = 1,
                  rel_widths = c(10, 10),
                   labels = c("C", "D"),
                   label_size = 8,
                   label_fontface = "bold")

gp <- plot_grid(row1,
          row2,
          nrow = 2,
          # rel_heights = c(3, 2),
          # align = "v",
          # axis = "rl",
          label_size = 8,
          label_fontface = "bold")

wo <- grid::convertUnit(unit(483, "pt"), "mm", valueOnly = TRUE)
ho <- grid::convertUnit(unit(483 * (1/2 + 1/3), "pt"), "mm", valueOnly = TRUE)
ggsave("fig/figure_1.pdf",
       gp,
       width = wo,
       height = ho,
       unit = "mm",
       device = cairo_pdf)
