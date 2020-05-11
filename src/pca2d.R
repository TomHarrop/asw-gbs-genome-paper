#!/usr/bin/env Rscript

library(adegenet)
library(data.table)
library(ggplot2)
library(vcfR)

###########
# GLOBALS #
###########

vcf_file <- "data/populations.geo.pruned.vcf" # reference-mapped, ld-pruned 20200429

# roughly north to south
pop_order <- c(
    "Coromandel" = "Coromandel",
    "Ruakura" = "Ruakura",
    "Taranaki" = "Taranaki",
    "Wellington" = "Wellington",
    "Greymouth" = "Greymouth",
    "Lincoln" = "Lincoln",
    "O" = "Ophir",
    "Mararoa" = "Mararoa Downs",
    "Mossburn" = "Mossburn",
    "Fortrose" = "Fortrose")


########
# MAIN #
########

vcf <- read.vcfR(vcf_file)
snp_data <- vcfR2genlight(vcf)

# impute NAs on mean
na_means <- tab(snp_data, NA.method = "mean")
snps_imputed <- new("genlight", na_means)
ploidy(snps_imputed) <- 2

# add pop
pops <- gsub("^[[:alpha:]]+_([[:alpha:]]+).*", "\\1", snps_imputed$ind.names)
pop(snps_imputed) <- factor(pops, levels = names(pop_order))

# run the pca
pca <- glPca(snps_imputed, nf = Inf)
pct_var <- 100 * (pca$eig^2)/(sum(pca$eig^2))

# set up a plot title
gt <- paste0(length(unique(snps_imputed$ind.names)),
             " individuals genotyped at ", 
             format(snps_imputed$n.loc, big.mark = ","),
             " loci")

# generate pca plot data
pca_dt <- data.table(pca$scores, keep.rownames = TRUE)
setnames(pca_dt, "rn", "individual")
pca_dt[, population := gsub("^[[:alpha:]]+_([[:alpha:]]+).*", "\\1", individual)]
pca_dt[, population := factor(plyr::revalue(as.character(population), pop_order),
                              levels = pop_order)]


pca_2d <- ggplot(pca_dt, aes(x = PC1, y = PC2, colour = population)) +
    theme_minimal(base_size = 8 ) +
    theme(legend.key.size = unit(0.8, "lines")) +
    coord_fixed() +
    scale_colour_viridis_d(direction = -1,
                           guide = guide_legend(title = NULL)) +
    xlab(paste0("PC1 (", round(pct_var[[1]], 1), "%)")) + 
    ylab(paste0("PC2 (", round(pct_var[[2]], 1), "%)")) + 
    geom_point(alpha = 0.8, shape = 16)

wo <- grid::convertUnit(unit(483 * (9/16), "pt"), "mm", valueOnly = TRUE)
ho <- grid::convertUnit(unit(483 * (1/2), "pt"), "mm", valueOnly = TRUE)
ggsave("fig/pca2d.pdf",
       pca_2d,
       width = wo,
       height = ho,
       unit = "mm",
       device = cairo_pdf)
saveRDS(pca_2d, "fig/pca2d.Rds")

