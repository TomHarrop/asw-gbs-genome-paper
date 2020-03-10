#!/usr/bin/env Rscript

library(adegenet)
library(data.table)
library(ggplot2)
library(ggmap)
library(cowplot)

f1a <- readRDS("fig/location_map.Rds")
f1b <- readRDS("fig/pca2d.Rds")

gp <- plot_grid(f1a + xlab("Longitude") + ylab("Latitude"),
          f1b,
          align = "hv",
          axis = "bl",
          nrow = 1,
          rel_widths = c(9, 11),
          labels = c("A", "B"),
          label_size = 8,
          label_fontface = "bold")
wo <- grid::convertUnit(unit(483, "pt"), "mm", valueOnly = TRUE)
ho <- grid::convertUnit(unit(483 * (1/2), "pt"), "mm", valueOnly = TRUE)
ggsave("fig/figure_1.pdf",
       gp,
       width = wo,
       height = ho,
       unit = "mm",
       device = cairo_pdf)

