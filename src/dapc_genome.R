#!/usr/bin/env Rscript

library(adegenet)
library(vcfR)
library(data.table)
library(ggplot2)

###########
# GLOBALS #
###########

vcf_file <- "data/populations.snps.vcf" # reference-mapped, 20200421

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

# construct genind
vcf <- read.vcfR(vcf_file)
snp_data <- vcfR2genlight(vcf)

# impute
na_means <- tab(snp_data, NA.method = "mean")
snps_imputed <- new("genlight",
                    na_means,
                    ploidy = 2)

# add pop
pops <- gsub("^[[:alpha:]]+_([[:alpha:]]+).*", "\\1", snps_imputed$ind.names)
pop(snps_imputed) <- factor(pops, levels = names(pop_order))

# cross validate
xv <- xvalDapc(tab(snps_imputed),
               pop(snps_imputed),
               n.pca.max = 20,
               training.set = 0.9,
               result = "groupMean",
               center = TRUE,
               scale = FALSE, 
               n.pca = 1:20,
               n.rep  = 3,
               xval.plot = TRUE)

xv_npca <- which.min(xv$`Root Mean Squared Error by Number of PCs of PCA`)

# optimisation (vs. xv)
# dapc_results_opt <- dapc(snps_imputed,
#                          n.pca = 20,
#                          n.da = length(pop_order) - 1)
# 
# opt <- optim.a.score(dapc_results_opt,
#                      n.pca = 1:50,
#                      n.sim = 10)

# run the dapc
dapc_results <- dapc(snps_imputed,
                     n.pca = xv_npca,
                     n.da = length(pop_order) - 1)

dapc_var <- 100 * (dapc_results$eig^2)/(sum(dapc_results$eig^2))


# loadings?
# vc <- data.table(dapc_results$var.contr,
#                  loc_name = snps_imputed$loc.names)
# setorder(vc, -LD1)
# x <- snps_imputed[, snps_imputed$loc.names == vc[1, loc_name]]
# tab(x, freq = TRUE)

# generate dapc plot data
dapc_dt <- data.table(dapc_results$ind.coord, keep.rownames = TRUE)
setnames(dapc_dt, "rn", "individual")
dapc_long <- melt(dapc_dt,
                  id.vars = "individual",
                  variable.name = "component",
                  value.name = "score")
dapc_long[, population := gsub("^[[:alpha:]]+_([[:alpha:]]+).*", "\\1", individual)]
dapc_long[, population := factor(plyr::revalue(as.character(population), pop_order),
                                 levels = pop_order)]

dapc_pd <- merge(dapc_long,
                 data.table(component = paste0("LD", 1:length(dapc_var)),
                            dapc_var = dapc_var),
                 all.y = FALSE)
# dapc_pd[, population := factor(population, levels = pop_order)]
dapc_pd[, facet_label := paste0(component, " (", round(dapc_var, 1), "%)")]

# plot the dapc
dapc_plot <- ggplot(dapc_pd[dapc_var > 1],
                    aes(x = population, y = score, colour = population)) +
    theme_minimal(base_size = 8 ) +
    theme(legend.key.size = unit(0.8, "lines")) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5),
          panel.border = element_rect(fill = NA, colour = "black"),
          strip.placement = "outside") +
    xlab(NULL) + ylab(NULL) +
    ylim(c(-6, 6)) +
    facet_wrap(~facet_label,
               scales = "free",
               strip.position = "left") +
    scale_colour_viridis_d(direction = -1,
                           guide = FALSE) +
    geom_boxplot(fill = NA,
                 colour = alpha("black", 0.5),
                 outlier.colour = NA,
                 width = 0.5) +
    geom_point(shape = 16,
               alpha = 0.8,
               position = position_jitter(width = 0.2))


# posteriors
dapc_post_wide <- data.table(dapc_results$posterior, keep.rownames = TRUE)
dapc_post <- melt(dapc_post_wide, id.vars = "rn", variable.name = "pop", value.name = "prob")
dapc_post[, sample_pop := gsub("geo_([[:alpha:]]+).*", "\\1", rn)]

dapc_post[, pop := factor(plyr::revalue(as.character(pop), pop_order),
                          levels = rev(pop_order))]
dapc_post[, sample_pop := factor(plyr::revalue(as.character(sample_pop), pop_order),
                                 levels = pop_order)]

actual_pop <- dapc_post[pop == sample_pop]
setorder(actual_pop, -prob)
indiv_order <- actual_pop[, rn]

dapc_post[, rn := factor(rn, levels = unique(indiv_order))]

dapc_posteriors <- ggplot(dapc_post, aes(x = rn, y = prob, fill = pop)) +
    theme_minimal(base_size = 8) +
    theme(axis.text.x = element_blank(),
          strip.text = element_text(size = 5),
          legend.key.size = unit(0.8, "lines"),
          legend.position = "top") +
    xlab("Sample population") + ylab("Membership probability") +
    facet_grid(~ sample_pop,
               scales = "free_x",
               space = "free_x",
               switch = "x") +
    scale_y_continuous(expand = c(0, 0)) +
    scale_fill_viridis_d(
        direction = 1,
        guide = guide_legend(title = "Assigned population",
                            title.position = "top")) +
    geom_col()


# dapc_posteriors <- ggplot(dapc_post, aes(y = rn, x = prob, fill = pop)) +
#     theme_minimal(base_size = 8) +
#     theme(axis.text.y = element_blank(),
#           strip.text.y = element_text(angle = 180),
#           legend.key.size = unit(0.8, "lines")) +
#     ylab("Sample population") + xlab("Membership probability") +
#     facet_grid(sample_pop ~ .,
#                scales = "free_y",
#                space = "free_y",
#                switch = "y") +
#     scale_x_continuous(expand = c(0, 0)) +
#     scale_fill_viridis_d(direction = 1,
#                          guide = guide_legend(title = "Assigned\npopulation")) +
#     geom_col()


# write output
wo <- grid::convertUnit(unit(483, "pt"), "mm", valueOnly = TRUE)
ho <- grid::convertUnit(unit(483 * (1/3), "pt"), "mm", valueOnly = TRUE)
ggsave("fig/dapc_posteriors.pdf",
       dapc_posteriors,
       width = wo,
       height = ho,
       units = "mm",
       device = cairo_pdf)

ggsave("fig/dapc_genome.pdf",
       dapc_plot,
       width = wo,
       height = ho,
       units = "mm",
       device = cairo_pdf)

saveRDS(dapc_plot, "fig/dapc_genome.Rds")
saveRDS(dapc_posteriors, "fig/dapc_posteriors.Rds")
