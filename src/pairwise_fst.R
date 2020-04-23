#!/usr/bin/env Rscript

library(data.table)
library(ggplot2)

fst_file <- "data/populations.fst_summary.tsv"

# roughly north to south
pop_order <- c(
    "Coromandel" = "Coromandel",
    "Ruakura" = "Ruakura",
    "Taranaki" = "Taranaki",
    "Wellington" = "Wellington",
    "Greymouth" = "Greymouth",
    "Lincoln" = "Lincoln",
    "O" = "Ophir",
    "MararoaDowns" = "Mararoa Downs",
    "Mossburn" = "Mossburn",
    "Fortrose" = "Fortrose")

# read data
fst_mat_dt <- fread(fst_file)

# make long
pairwise_fst <- melt(fst_mat_dt,
                     id.vars = "V1",
                     measure.vars = names(fst_mat_dt)[names(fst_mat_dt) != "V1"],
                     variable.name = "pop2",
                     value.name = "Fst")

# fill missing values
setnames(pairwise_fst, "V1", "pop1")
filled_fst <- rbind(pairwise_fst[!is.na(Fst)],
                    pairwise_fst[!is.na(Fst),
                                 .(pop1 = pop2, pop2 = pop1, Fst = Fst)])

all_pop <- pairwise_fst[, unique(c(pop1, as.character(pop2)))]
fst_pd <- rbind(filled_fst,
                data.table(pop1 = all_pop,pop2=all_pop, Fst = 0))

# get population order
fst_mat <- as.matrix(data.frame(dcast(fst_pd, pop1 ~ pop2), row.names = "pop1"))
hc <- hclust(as.dist(fst_mat), method = "ward.D2")
clust_order <- hc$labels[hc$order]

fst_pd[, pop1 := factor(pop1, levels = clust_order)]
fst_pd[, pop2 := factor(pop2, levels = clust_order)]

# fix pop
# fst_pd[, pop1 := plyr::mapvalues(pop1, names(pop_order), pop_order)]
# fst_pd[, pop2 := plyr::mapvalues(pop2, names(pop_order), pop_order)]

# set up label colours
my_cols <- structure(rev(viridisLite::viridis(length(pop_order))),
                     names = pop_order)
lab_cols <- plyr::revalue(clust_order, my_cols)

# draw the plot
fill_cols <- RColorBrewer::brewer.pal(7, "YlOrRd")

gp <- ggplot(fst_pd, aes(x = pop1, y = pop2, fill = Fst)) +
    theme_minimal(base_size = 8 ) +
    theme(axis.text.x = element_text(angle = 90,
                                     hjust = 1,
                                     vjust = 0.5,
                                     colour = lab_cols),
          axis.text.y = element_text(colour = lab_cols),
          legend.key.size = unit(0.8, "lines")) +
    xlab(NULL) + ylab(NULL) +
    scale_x_discrete(expand = c(0, 0)) +
    scale_y_discrete(expand = c(0, 0)) +
    scale_fill_gradientn(
        colours = fill_cols,
        guide = guide_colorbar(
            title = expression(italic("F")["ST"]))) +
    geom_raster()

wo <- grid::convertUnit(unit(483 * (1/2), "pt"), "mm", valueOnly = TRUE)
ho <- grid::convertUnit(unit(483 * (1/2), "pt"), "mm", valueOnly = TRUE)
ggsave("fig/pairwise_fst.pdf",
       gp,
       width = wo,
       height = ho,
       unit = "mm",
       device = cairo_pdf)
saveRDS(gp, "fig/pairwise_fst.Rds")

