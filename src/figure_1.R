#!/usr/bin/env Rscript

library(ggplot2)
library(ggmap)
library(cowplot)

map <- readRDS("fig/location_map.Rds")
het <- readRDS("fig/obs_het.Rds")
fst <- readRDS("fig/pairwise_fst.Rds")
pca <- readRDS("fig/pca2d.Rds")
dapc <- readRDS("fig/dapc_genome.Rds")
admix <- readRDS("fig/dapc_posteriors.Rds")


lon_bump <- 0.225
lat_bump <- 0

r_col <- plot_grid(het,
                   fst + coord_fixed(),
                   ncol = 1,
                   labels = c("B", "C"),
                   label_size = 8, 
                   label_fontface = "bold")

row_1 <- plot_grid(map,
                   r_col,
                   nrow = 1,
                   rel_widths = c(6, 4),
                   labels = c("A", ""),
                   label_size = 8,
                   label_fontface = "bold")


row_2 <- plot_grid(pca + guides(colour = FALSE),
                   dapc,
                   nrow = 1,
                   rel_widths = c(1, 2),
                   labels = c("D", "E"),                   
                   label_size = 8,
                   label_fontface = "bold")


gp <- plot_grid(row_1,
                row_2,
                admix,
                nrow = 3,
                rel_heights = c(2, 1, 1),
                labels = c("", "", "F"),
                label_size = 8,
                label_fontface = "bold")

wo <- grid::convertUnit(unit(483, "pt"), "mm", valueOnly = TRUE)
ho <- sqrt(2) * wo * 0.9
# ho <- grid::convertUnit(unit(483, "pt"), "mm", valueOnly = TRUE)
ggsave("fig/figure_1.pdf",
       gp,
       width = wo,
       height = ho,
       unit = "mm",
       device = cairo_pdf)
