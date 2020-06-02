#!/usr/bin/env Rscript

library(data.table)
library(ggplot2)

# pick a qval cutoff
fdr_cutoff <- 1e-2


# "output/060_popgen/populations.ns.all.vcf"
vcf_file <- "data/populations.ns.all.vcf"
fai_file <- "data/draft_genome.fasta.fai"
# "output/080_bayescan/ns.all/bs/populations_fst.txt"
bs_file <- "data/populations_fst.txt"

# get a list of loci to match with bs results
vcf_names <- c("chrom", "pos", "id", "ref", "alt", "qual")
loci <- fread(cmd = paste('grep -v "^#"', vcf_file),
              header = FALSE,
              col.names = vcf_names,
              select = 1:6)
loci[, snp_no := seq(1, .N)]

# read the FAI
fai_names <- c("Chr", "chr_length")
fai <- fread(fai_file, select = 1:2, col.names = fai_names)

# bayescan results
bs_names <- c("snp_no", "prob", "log10_PO", "qval", "alpha", "fst")
bs <- fread(bs_file,
            col.names = bs_names,
            skip = 1,
            header = FALSE)

# add locus info to bayescan results
bs_loci <- merge(bs, loci, by = "snp_no")
bs_loci[, nlog10_q := -log10(qval)]

# set up chromosome coordinates
chr_coords <- copy(fai)
setorder(chr_coords, -chr_length, Chr)
chr_coords[, chr_end := cumsum(chr_length)]
chr_coords[, chr_start := chr_end - chr_length + 1]

bs_coords <- merge(bs_loci,
                   chr_coords,
                   by.x = "chrom",
                   by.y = "Chr",
                   all.x = TRUE,
                   all.y = FALSE)
setorder(bs_coords, -chr_length, chrom, pos)
bs_coords[, bp_coord := pos + chr_start - 1]

# which Chr to plot
sig_chrom <- bs_loci[qval < fdr_cutoff, unique(chrom)]
bs_pd <- bs_coords[chrom %in% sig_chrom]
max_q <- bs_pd[!is.infinite(nlog10_q), max(nlog10_q)]
bs_pd[, is_inf := is.infinite(nlog10_q)]
bs_pd[is_inf == TRUE, nlog10_q := max_q]
bs_pd[, chrom := factor(chrom, levels = gtools::mixedsort(unique(chrom)))]

# set lims
pd_lims <- bs_pd[, .(nlog10_q = max(nlog10_q),
          pos = chr_length),
      by = chrom]

gp <- ggplot(pd_lims, aes(x = pos,
                    y = nlog10_q,
                    colour = alpha,
                    shape = is_inf)) +
  theme_minimal(base_size = 8) +
  theme(axis.text.x = element_blank(),
        strip.text.x = element_text(angle = 90,
                                    hjust = 1,
                                    vjust = 0.5),
        panel.background = element_rect(colour = "black"),
        legend.key.size = unit(0.5, "lines"), 
        panel.grid.major.x = element_blank()) +
  facet_grid(cols = vars(chrom),
             scales = "free_x",
             space = "free_x",
             switch = "x") +
  scale_colour_viridis_c(guide = guide_colourbar(title = expression(alpha))) +
  scale_shape_manual(values = c(16, 8),
                     guide = FALSE) +
  xlab(NULL) +
  ylab(expression(-log[10](italic(Q)))) +
  xlim(c(0, NA)) +
  geom_point(data = pd_lims,
             colour = rep(NA, pd_lims[, .N]),
             shape = 16,
             size = 1) +
  geom_point(data = bs_pd,
             size = 1)

wo <- grid::convertUnit(unit(483, "pt"), "mm", valueOnly = TRUE)
ho <- grid::convertUnit(unit(483 * 1/3, "pt"), "mm", valueOnly = TRUE)
ggsave("fig/figure_2.pdf",
       gp,
       width = wo,
       height = ho,
       unit = "mm",
       device = cairo_pdf)

