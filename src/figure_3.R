#!/usr/bin/env Rscript

library(data.table)
library(ggplot2)
library(cowplot)
library(magick)

# model 0: iv, model 1: i, model 2: iii, model 3: ii, model 4: v
model_map <- c(
    model1 =   "i",
    model3 =  "ii",
    model2 = "iii",
    model0 =  "iv",
    model4 =   "v")

# asw-stacks-singleplate/output/095_fastsimcoal/ns.pruned/summary.csv
model_file <- "data/summary.csv"
model_diagram <- image_read_pdf("fig/models_fig_170ns.pdf")

# set up labels
model_data <- fread(model_file)
model_data[, plot_model := factor(plyr::revalue(model, model_map),
                                  levels = model_map)]
model_data[mig == "mig", mig := "With migration"]
model_data[mig == "no_mig", mig := "Without migration"]

# deal with inf
max_lhood <- model_data[is.finite(Lhood), max(Lhood)]
model_data[, is_inf := is.infinite(Lhood)]
model_data[is_inf == TRUE, Lhood := max_lhood]

# summary table?
model_summary <- model_data[, data.table(t(summary(Lhood))), by = .(plot_model, mig)]
model_summary[V2 == "Mean"]

lhood_plot <- ggplot(model_data[is_inf == FALSE],
                     aes(x = plot_model,
                         y = Lhood,
                         colour = mig)) +
    theme_minimal(base_size = 8) +
    theme(legend.position = "top",
          legend.key.size = unit(0.8, "lines"),
          legend.direction = "vertical") +
    scale_color_viridis_d(
        guide = guide_legend(title = NULL,
                             override.aes = list(shape = 16, alpha = 1))) +
    xlab("Model") + ylab("Delta likelihood") +
    geom_point(position = position_jitterdodge(jitter.width = 0.25),
               alpha = 0.5,
               size = 3,
               shape = 16) +
    geom_point(data = model_data[is_inf == TRUE],
               position = position_jitterdodge(jitter.width = 0.25),
               alpha = 0.5,
               size = 3,
               shape = 8)

wo <- grid::convertUnit(unit(483, "pt"), "mm", valueOnly = TRUE)
ho <- grid::convertUnit(unit(483 * 2/3, "pt"), "mm", valueOnly = TRUE)

gp <- plot_grid(ggdraw() + draw_image(model_diagram),
                lhood_plot,
                # align = "v",
                # axis = "b",
                labels = c("A", "B"),
                label_size = 8,
                label_fontface = "bold",
                ncol = 1)

ggsave("fig/figure_3.pdf",
       gp,
       width = wo,
       height = ho,
       unit = "mm",
       device = cairo_pdf)
