#!/usr/bin/env Rscript

library(data.table)
library(ggplot2)



# pick a qval cutoff
fdr_cutoff <- 1e-2

# "output/080_bayescan/ns.all/bs/populations_fst.txt"
bs_file <- "data/populations_fst.txt"

# "output/060_popgen/populations.ns.all.vcf"
vcf_file <- "data/populations.ns.all.vcf"

# fai_file <- "output/005_ref/ref.fasta.fai"
fai_file <- "data/draft_genome.fasta.fai"

# asw-annotate/output/020_funannotate/annotate_results/ASW.annotations.txt
annot_file <- "data/ASW.annotations.txt"
annot <- fread(annot_file)

# entry list (from interproscan)
entry_list_file <- "data/entry.list"
entry_list <- fread(entry_list_file)

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

# get the genes
sig_chr <- bs_loci[qval < fdr_cutoff, unique(chrom)]
genes_on_sig_chr <- annot[Contig %in% sig_chr, unique(GeneID)]

# phyper of go, IPR, EGGNOG terms?
gene_to_id <- rbindlist(list(
    interpro = annot[, .(
        id = unlist(strsplit(InterPro, ";", fixed = TRUE))),
        by = GeneID],
    go = annot[, .(
        id = unlist(strsplit(`GO Terms`, ";", fixed = TRUE))),
        by = GeneID],
    pfam = annot[, .(
        id = unlist(strsplit(PFAM, ";", fixed = TRUE))),
        by = GeneID]),
    idcol = "annot_type")
sig_gene_to_id <- gene_to_id[GeneID %in% genes_on_sig_chr]    
sig_annot_id <- sig_gene_to_id[, unique(id)]    

sig_gene_to_id[, sig_id := id]
phyp_dt <- sig_gene_to_id[, .(
    q = .N,
    m = gene_to_id[id == sig_id, length(unique(GeneID))],
    k = length(unique(genes_on_sig_chr))
), by = sig_id]
phyp_dt[, n := gene_to_id[, length(unique(GeneID))] - m]
phyp_dt[q > 1, p := 1 - phyper(q - 1, m, n, k, lower.tail = TRUE, log.p = FALSE)]
phyp_dt[, padj := p.adjust(p, "BH")]
setorder(phyp_dt, padj, na.last = TRUE)
phyp_dt[startsWith(sig_id, "PF")]

x <- merge(phyp_dt, entry_list, by.x = "sig_id", by.y = "ENTRY_AC")
setorder(x, padj, na.last = TRUE)
x[!is.na(padj)]

all the eggnogs are ENOG41
# eggnog = sig_annot[, .(
#     id = unlist(strsplit(EggNog, ";", fixed = TRUE))),
#     by = GeneID])






# add chrom length during summary
setkey(fai, "Chr")
bs_loci[chrom %in% sig_chr,
        .(chrom_len = fai[chrom, chr_length],
          sig_snps = sum(qval < fdr_cutoff)),
        by = chrom]



