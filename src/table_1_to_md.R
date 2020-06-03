#!/usr/bin/env Rscript

library(data.table)

gt <- fread("tables/genome_table.csv", header = TRUE)

pander::pandoc.table(gt,
                     style = "rmarkdown", 
                     split.tables = Inf)
