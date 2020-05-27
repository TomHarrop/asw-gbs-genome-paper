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

# all the eggnogs are ENOG41
# eggnog = sig_annot[, .(
#     id = unlist(strsplit(EggNog, ";", fixed = TRUE))),
#     by = GeneID])


# get the closest gene to each sig snp



my_chrom <- "contig_1196"
my_snp <- 393177
my_id <- "28752:63:-"

GetClosestGene <- function(my_chrom, my_snp, my_id, annot) {
    chrom_cds <- annot[Contig == my_chrom & Feature == "CDS"]
    chrom_cds[, snp_distance := abs(my_snp - as.integer(Start + (Stop - Start)/2))]
    chrom_cds[, c("snp_loc", "snp_id") := .(my_snp, my_id)]
    return(chrom_cds)
}

snp_to_genes <- bs_loci[
    qval < fdr_cutoff,
    GetClosestGene(my_chrom = chrom,
                   my_snp = pos,
                   my_id = id,
                   annot = annot),
    by = id]

i <- snp_to_genes[, .I[which.min(snp_distance)], by = id][, V1]

closest_per_snp <- snp_to_genes[i]

a_row <-closest_per_snp[1]
out_file <- "blah.fa"

closest_per_snp[, z := t(list(paste(">", GeneID), Translation))]

WriteFa <- function(a_row, out_file){
    print(a_row)
    write(paste(">", a_row[, GeneID]), out_file, append = TRUE)
    write(a_row[, Translation], out_file, append = TRUE)
}

unique(closest_per_snp, by = "GeneID")[
    , WriteFa(a_row = .SD, out_file = "blah.fa"), by = id]

closest_per_snp[, summary(snp_distance)]


# add chrom length during summary
setkey(fai, "Chr")
bs_loci[chrom %in% sig_chr,
        .(chrom_len = fai[chrom, chr_length],
          sig_snps = sum(qval < fdr_cutoff)),
        by = chrom]



