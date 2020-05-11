#!/usr/bin/env Rscript

library(data.table)
library(ggplot2)


###########
# GLOBALS #
###########
# 070_populations/geo/populations.sumstats_summary.tsv, 20200429
summary_file <- "data/populations.sumstats_summary.tsv" 

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


########
# MAIN #
########

sumstats <- fread(summary_file, skip = 1, nrows = 10)

# fix the duplicate colnames (thanks stacks)
all_names <- names(sumstats)
dup_names <- which(duplicated(all_names))
unique_names <- which(!duplicated(all_names))

GenerateColNames <- function(i){
    ifelse(i %in% unique_names,
           all_names[i],
           paste(
               all_names[max(unique_names[i - unique_names > 0])],
               all_names[i],
               sep = "."
           ))
}

new_names <- sapply(1:length(all_names), GenerateColNames)
names(sumstats) <- new_names

# fix pop
sumstats[, pop := plyr::mapvalues(`# Pop ID`, names(pop_order), pop_order)]
sumstats[, pop := factor(pop, levels = rev(pop_order))]

# obs het plot
gp <- ggplot(sumstats, aes(y = pop,
                     x = Obs_Het,
                     xmin = Obs_Het - `Obs_Het.StdErr`,
                     xmax = Obs_Het + `Obs_Het.StdErr`,
                     fill = pop)) +
    theme_minimal(base_size = 8 ) +
    scale_fill_viridis_d(direction = 1,
                         guide = FALSE) +
    ylab(NULL) +
    xlab("Mean heterozygosity ± SEM") +
    geom_col() +
    geom_errorbarh(height = 0.1)

wo <- grid::convertUnit(unit(483 * (1/2), "pt"), "mm", valueOnly = TRUE)
ho <- grid::convertUnit(unit(483 * (1/2), "pt"), "mm", valueOnly = TRUE)
ggsave("fig/obs_het.pdf",
       gp,
       width = wo,
       height = ho,
       unit = "mm",
       device = cairo_pdf)
saveRDS(gp, "fig/obs_het.Rds")



