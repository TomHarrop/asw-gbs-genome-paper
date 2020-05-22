
library(data.table)
library(rtracklayer)
library(ggplot2)
library(scales)

# asw-flye-withpool/output/095_repeatmasker/purge_haplotigs/purge_haplotigs.sorted.fa.out.gff
gff_file <- "data/purge_haplotigs.sorted.fa.out.gff"

my_gff <- import.gff(gff_file)
reduced_gff <- reduce(my_gff)

# these are the repeat regions
gff_dt <- as.data.table(reduced_gff)

# these are the bits in between repeats
reduced_gaps <- as.data.table(gaps(reduced_gff))


gff_dt[, summary(width)]
gff_dt[, hist(log(width, 4))]

# repeat n50 length
setorder(gff_dt, width)
gff_dt[, cs := cumsum(width)]
gff_dt[cs / sum(width) >= 0.5, min(width)]

# non-repeat n50 length
setorder(reduced_gaps, width)
reduced_gaps[, hist(log(width, 4))]
reduced_gaps[, summary(width)]
reduced_gaps[, cs := cumsum(width)]
reduced_gaps[cs / sum(width) >= 0.5, min(width)]

# plots
rpt_pd <- rbindlist(list("Repeat regions" = gff_dt,
                         "Not repeat regions" = reduced_gaps),
                    idcol = "region")
reg_cnt <- rpt_pd[, .(count = .N), by = .(width, region)]


ggplot(rpt_pd, aes(x = width)) +
    scale_x_continuous(trans = log_trans(base = 4),
                       breaks = trans_breaks(function(x) log(x, 4),
                                             function(x) 4^x)) +
    geom_histogram()

ggplot(reg_cnt, aes(x = width, y = count, colour = region)) +
    scale_x_continuous(trans = log_trans(base = 4),
                       breaks = trans_breaks(function(x) log(x, 4),
                                             function(x) 4^x)) +
    scale_y_log10() +
    geom_smooth(se = FALSE, span = 0)

ggplot(rpt_pd, aes(x = width)) +
    scale_x_continuous(trans = log_trans(base = 4),
                       breaks = trans_breaks(function(x) log(x, 4),
                                             function(x) 4^x)) +
    geom_histogram()


