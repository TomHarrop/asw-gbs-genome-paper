#!/usr/bin/env/Rscript

library(data.table)
library(ggplot2)
library(scales)

# plot size
wo <- grid::convertUnit(unit(483, "pt"), "mm", valueOnly = TRUE)
ho <- grid::convertUnit(unit(483 * (1/2), "pt"), "mm", valueOnly = TRUE)

# genome index
fai_file <- "data/draft_genome.fasta.fai"
# output/popgen/mapped/bak.stacks_populations/populations.phistats.tsv
phistats_file <- "data/populations.phistats_North-South.tsv"

phistats <- fread(phistats_file, skip = 2)

fai_names <- c("Chr", "chr_length")

fai <- fread(fai_file, select = 1:2, col.names = fai_names)

n_to_label <- 20

# chromosome coordinates
chr_coords <- copy(fai)
setorder(chr_coords, -chr_length, Chr)
chr_coords[, chr_end := cumsum(chr_length)]
chr_coords[, chr_start := chr_end - chr_length + 1]
chr_coords[, lab_pos := chr_start + round(mean(c(chr_start, chr_end)), 0), by = Chr]
pos_to_label = chr_coords[, seq(1, max(chr_end), length.out = n_to_label)]

label_positions <- sapply(pos_to_label, function(x)
  chr_coords[, .I[which.min(abs(x - lab_pos))]])

chr_coords[label_positions, x_lab := Chr]
chr_coords[is.na(x_lab), x_lab := ""]

# homemade manhattan plot
phistats_with_len <- merge(phistats, chr_coords, by = "Chr")
setorder(phistats_with_len, -chr_length, Chr, BP)
phistats_with_len[, bp_coord := BP + chr_start - 1]

# pick out the outliers
q99 <- phistats_with_len[, quantile(phi_st, 0.99)]
phistats_with_len[phi_st > q99, outlier := TRUE]
phistats_with_len[outlier == TRUE, point_colour := Chr]
phistats_with_len[is.na(outlier), point_colour := NA]

# order the contigs
linecol <- viridisLite::viridis(9)[9]
phistats_with_len[
  , point_colour := factor(point_colour,
                           levels = unique(gtools::mixedsort(point_colour, na.last = TRUE)))]

whole_genome_gp <- ggplot() +
  theme_minimal(base_size = 8 ) +
  theme(axis.text.x = element_text(angle = 30,
                                   hjust = 1,
                                   vjust = 1),
        axis.ticks.x = element_blank(),
        axis.ticks.length.x = unit(0, "mm"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank()) +
  xlab(NULL) +
  scale_x_continuous(breaks = chr_coords[, lab_pos],
                     labels = chr_coords[, x_lab]) +
  scale_colour_viridis_d(guide = FALSE) +
  geom_hline(yintercept = q99,
             colour = linecol) +
  geom_point(mapping = aes(x = bp_coord,
                           y = `phi_st`),
             data = phistats_with_len[is.na(point_colour)],
             size = 1,
             shape = 16,
             alpha = 0.8) +
  geom_point(mapping = aes(x = bp_coord,
                           y = `phi_st`,
                           colour = point_colour),
             data = phistats_with_len[!is.na(point_colour)],
             size = 1,
             shape = 16,
             alpha = 0.8)

ggsave("fig/whole_genome_fst.pdf",
       whole_genome_gp,
       width = wo,
       height = ho,
       units = "mm",
       device = cairo_pdf)

# d99 <- phistats_with_len[, quantile(`Smoothed D_est`, 0.99)]
# ggplot(phistats_with_len, aes(x = bp_coord, y = `Smoothed D_est`)) +
#   theme(axis.text.x = element_text(angle = 30,
#                                    hjust = 1,
#                                    vjust = 1),
#         axis.ticks.x = element_blank(),
#         axis.ticks.length.x = unit(0, "mm")) +
#   scale_x_continuous(breaks = chr_coords[, lab_pos],
#                      labels = chr_coords[, x_lab]) +
#   geom_hline(yintercept = d99) +
#   geom_point()

# plot contigs with more than one outlier SNP
plot_contig <- phistats_with_len[outlier == TRUE, .N, by = Chr][N > 1, unique(Chr)]
plot_dt <- phistats_with_len[Chr %in% plot_contig]

single_contig_plot <- ggplot() +
  theme_minimal(base_size = 8 ) +
  xlab(plot_contig) + 
  scale_colour_viridis_d(guide = FALSE) +
  geom_hline(yintercept = q99,
             colour = linecol) +
  geom_point(mapping = aes(x = bp_coord,
                           y = `phi_st`),
             data = plot_dt[is.na(point_colour)],
             size = 1,
             shape = 16) +
  geom_point(mapping = aes(x = bp_coord,
                           y = `phi_st`,
                           colour = point_colour),
             data = plot_dt[!is.na(point_colour)],
             size = 1,
             shape = 16)

single_contig_plot


ggsave("fig/single_contig_fst.pdf",
       single_contig_plot,
       width = wo,
       height = ho,
       units = "mm",
       device = cairo_pdf)


# distance between markers
phistats_with_len[, prev_loc := c(0, bp_coord[-.N])]
phistats_with_len[, distance_from_prev := bp_coord - prev_loc]
phistats_with_len[, summary(distance_from_prev)]

distance_plot <- ggplot(phistats_with_len,
                        aes(y = distance_from_prev, x = bp_coord)) +
  theme_minimal(base_size = 8 ) +
  theme(axis.text.x = element_text(angle = 30,
                                   hjust = 1,
                                   vjust = 1),
        axis.ticks.x = element_blank(),
        axis.ticks.length.x = unit(0, "mm"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank()) +
  xlab(NULL) + ylab("Distance from previous SNP") +
  scale_x_continuous(breaks = chr_coords[, lab_pos],
                     labels = chr_coords[, x_lab]) +
  scale_y_continuous(
    trans = "log10",
    labels = trans_format("log10", math_format(10^.x)),
    breaks = trans_breaks("log10", function(x) 10^x)) +
  geom_point(
    size = 1,
    shape = 16,
    alpha = 0.8) +
  geom_hline(yintercept = phistats_with_len[, mean(distance_from_prev)],
             colour = linecol) +
  geom_text(data = data.table(
    distance_from_prev = phistats_with_len[, mean(distance_from_prev)],
    bp_coord = 0,
    label = round(
      phistats_with_len[, mean(distance_from_prev)] / 1e3,
      0)),
    mapping = aes(label = label),
    colour = linecol,
    hjust = "left",
    vjust = "bottom")


ggsave("fig/distance_plot.pdf",
       distance_plot,
       width = wo,
       height = ho,
       units = "mm",
       device = cairo_pdf)







phi_with_len <- merge(phistats, fai, by = "Chr")
x <- phi_with_len[, .(mean_phi = mean(phi_st), .N), by = .(Chr, chr_length)]
x[, distance_bw_markers := chr_length / N]


ggplot(x, aes(y = V1, x = V2)) +
  geom_point()


ggplot(x, aes(y = N, x = V2)) + geom_point()

ggplot(x[N>5], aes(y = distance_bw_markers, x = V2)) + geom_point()
x[N>5]
