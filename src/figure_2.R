#!/usr/bin/env Rscript

library(ggplot2)
library(cowplot)

f2a <- readRDS("fig/dapc_genome.Rds")
f2b <- readRDS("fig/dapc_posteriors.Rds")

gp <- plot_grid(f2a,
                f2b,
                nrow = 2,
                # rel_heights = c(3, 2),
                # align = "v",
                # axis = "rl",
                labels = c("A", "B"),
                label_size = 8,
                label_fontface = "bold")

wo <- grid::convertUnit(unit(483, "pt"), "mm", valueOnly = TRUE)
ho <- grid::convertUnit(unit(483 * 2/3, "pt"), "mm", valueOnly = TRUE)
ggsave("fig/figure_2.pdf",
       gp,
       width = wo,
       height = ho,
       unit = "mm",
       device = cairo_pdf)
