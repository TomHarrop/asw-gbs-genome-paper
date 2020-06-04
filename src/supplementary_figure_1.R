#!/usr/bin/env Rscript

# set log
log <- file(snakemake@log[[1]], open = "wt")
sink(log, type = "message")
sink(log, append = TRUE, type = "output")

library(data.table)
library(bit64)
library(ggplot2)
library(scales)
library(cowplot)

###########
# GLOBALS #
###########

hist_before_file <- "data/asw_hist.txt"
hist_after_file <- "data/asw_hist-out.txt"
peak_file <- "data/asw_peaks.txt"

########
# kmer #
########

# read data
peaks <- fread(paste("grep '^[^#]'", peak_file))

hist_files <- c(Raw = hist_before_file, Normalised = hist_after_file)
hist_data_list <- lapply(hist_files, fread)
combined_data <- rbindlist(hist_data_list, idcol = "type")

# arrange plot
combined_data[, type := factor(type, levels = c("Raw", "Normalised"))]

# hlines
mincov <- peaks[2, V1]
p1 <- peaks[2, V2]
maxcov <- peaks[2, V3]
peak_pd <- combined_data[type == "Raw" & between(`#Depth`, mincov, maxcov)]

# plot title
# gt <- paste0(
#     p1, "× 31-mer coverage. ",
#     "Main peak: ", mincov, "×–", maxcov, "×"
# )

# plot
vd <- viridisLite::viridis(3)
line_col <- vd[[1]]
peak_col <- alpha(vd[[2]], 0.5)
kmer_plot <- ggplot(combined_data,
                    aes(x = `#Depth`,
                        y = Unique_Kmers,
                        linetype = type)) +
    theme_minimal(base_size = 8) +
    theme(legend.position = c(5/6, 2/4),
          legend.key.size = unit(0.5, "lines")) +
    geom_path(alpha = 0.75, colour = line_col) +
    geom_ribbon(data = peak_pd,
                mapping = aes(ymin = 0,
                              ymax = Unique_Kmers,
                              x = `#Depth`), colour = NA, fill = peak_col,
                show.legend = FALSE) +
    scale_linetype_discrete(guide = guide_legend(title = NULL)) +
    scale_y_continuous(
        trans = "log10",
        labels = trans_format("log10", math_format(10^.x)),
        breaks = trans_breaks("log10", function(x) 10^x)) +
    scale_x_continuous(trans = log_trans(base = 4),
                       breaks = trans_breaks(function(x) log(x, 4),
                                             function(x) 4^x)) +
    xlab("31-mer depth") + ylab("Number of unique 31-mers")


########
# MAIN #
########

CalculateKhaStats <- function(x) {
    setkey(x, `#Depth`)
    x <- x[!last(x)]
    x[, cum_sum := cumsum(as.numeric(Raw_Count))]
    x[, percent_kmers := 100 * cum_sum / sum(Raw_Count)]
    return(x)
}

kha_data_list <- lapply(hist_data_list, CalculateKhaStats)
kha <- rbindlist(kha_data_list, idcol = "type")

kha_plot <- ggplot(kha, aes(x = `#Depth`, y = percent_kmers, colour = type)) +
    theme_minimal(base_size = 8) +
    theme(legend.justification = c("right", "bottom"),
          legend.position = c(0.9, 0.1),
          legend.key.size = unit(0.5, "lines"),
          axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
    scale_color_viridis_d(guide = guide_legend(title = NULL)) +
    xlab("Depth") + ylab("Cumulative percentage of read 31-mers") +
    ylim(c(0, 100)) +
    scale_x_continuous(trans = log_trans(base = 4),
                       breaks = trans_breaks(function(x) log(x, 4),
                                             function(x) 4^x)) +
    geom_path(alpha = 0.75)


# find the elbows
kha_diff <- kha[`#Depth` <= 256,
                .(diff_pct = diff(diff(Raw_Count) > 0) != 0,
                  `#Depth` = `#Depth`[c(-1, -2)],
                  percent_kmers = percent_kmers[c(-1, -2)]),
                by = type]

kha_diff[, percent_repeat :=
             paste0("~", round(100 - percent_kmers, 0), "% repeats")]

kha_with_elbows <- kha_plot +
    geom_hline(data = kha_diff[diff_pct == TRUE][c(5, 21)],
               mapping = aes(yintercept = percent_kmers,
                             colour = type),
               linetype = 2,
               show.legend = FALSE) +
    geom_text(data = kha_diff[diff_pct == TRUE][c(5, 21)],
              mapping = aes(label = percent_repeat,
                            x = 0),
              hjust = "left",
              vjust = -0.1,
              size = 2,
              show.legend = FALSE)


###########
# COMBINE #
###########

gp <- plot_grid(kmer_plot,
                kha_with_elbows,
                nrow = 1,
                rel_widths = c(2, 1),
                labels = c("A", "B"),
                label_size = 8,
                label_fontface = "bold")


# write output
wo <- grid::convertUnit(grid::unit(483, "pt"), "mm", valueOnly = TRUE)
ho <- grid::convertUnit(grid::unit(664/2, "pt"), "mm", valueOnly = TRUE)
ggsave(filename = "fig/supplementary_figure_1.pdf",
       plot = gp,
       device = cairo_pdf,
       width = wo,
       height = ho,
       units = "mm")
