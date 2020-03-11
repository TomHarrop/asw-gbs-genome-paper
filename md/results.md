## Results

### Variation in NZ populations of Argentine stem weevil

To measure genetic variation in invasive New Zealand populations of ASW, we collected individuals from 7 sites in the North Island and 5 sites in the South Island of New Zealand (Figure 1A).
We genotyped individuals with a modified genotyping-by-sequencing (GBS) protocol [@elshireRobustSimpleGenotypingbySequencing2011].
After strict filtering of the raw GBS data, we used *de novo* locus assembly with the Stacks pipeline [@catchenStacksAnalysisTool2013].
Our final dataset comprised 10--16 individuals per location (total 112), genotyped at more than 22 thousand loci.
Principal components analysis (PCA) of the genotypes revealed overlapping populations of ASW, with only 12.2% of total variance explained by the first two components (Figure 1B).
**Something about the general amount of variation e.g. heterozygosity measurement**.
These results suggest that there is a large amount of unstructured variation across New Zealand populations of ASW.

![
**Figure 1.**
**A** Weevil sampling locations.
We collected Argentine stem weevils from 4 locations in the North Island and 6 locations in the South Island of New Zealand.
The number of weevils genotyped from each location is show on the map.
The map was plotted with the ggmap package for ggplot2 [@kahleGgmapSpatialVisualization2013].
<!-- Cor (Coromandel),
Rua (Ruakura),
Tar (Taranaki),
Wel (Wellington),
Ree (Reefton),
Gre (Greymouth),
Lin (Lincoln),
Oph (Ophir),
Mar(?) (Mararoa Downs),
Mos (Mossburn),
For (Fortrose)
 -->
**B** Pricipal components analysis (PCA) of 112 individuals genotyped at 22,397 loci.
The first two principal components (PC1 and PC2) are shown.
The populations overlap on PC1 and PC2, but weevils sampled from higher latitudes tend to have lower scores on PC1 and PC2.
PC1 and PC2 together explain 12.2% of variance in the dataset, indicating a high level of unstructured genetic variation in weevil populations.
](fig/figure_1.pdf) 

### Genetic variation is not associated with parasitism by a biocontrol agent

To try to detect variation associated with parasitism by *Microctonus hyperodae* (*i.e.* selection exerted by the biocontrol agent), we genotyped weevils that had also been tested for the presence of a parasitoid larva.
These weevils were collected from **Lincoln, New Zealand?** and **Ruakura, New Zealand?**, because of the decline in parasitism rate recorded at these locations [@tomasettoIntensifiedAgricultureFavors2017].
After filtering and assembly, we genotyped **X** parasitised weevils and **Y** weevils without a detected parasitoid at **Z** loci.
**We did not detect SNPs that were associated with the presence of a parasitoid larva, although we were able to detect SNPs that were associated with the location the weevil was collected.
(Figure to show this).**
This suggests that the developing resistance of the weevil to biocontrol [@tomasettoIntensifiedAgricultureFavors2017] is not related to within-population genetic variation that allows some weevils to avoid parasitism or its effects.

### The draft Argentine stem weevil genome

To find genomic loci associated with between-population variation, we constructed a draft assembly of the ASW genome.
We initially attempted assembly from a single individual using PCR-free, short read sequencing.
This resulted in a fragmented assembly with low BUSCO scores (Table 1).
*k*-mer analysis on the raw short reads suggested 2.1% heterozygosity and a genomic repeat content of at least 28% (**Supporting Information**).
We then attempted to produce a long-read genome assembly using whole-genome amplification (WGA) of high molecular weight (HMW) DNA from a single individual, followed by sequencing on the Oxford Nanopore Technologies (ONT) MinION sequencer.
We produced 29.8 GB of quality-filtered reads with an *N*~50~ length of 9.0 KB.
The low read *N*~50~ length was caused by debranching of the amplified DNA by T7 Endonuclease I, which is necessary following multiple displacement amplification (see methods).
Assembling the single individual, long read genome resulted in improved contiguity and BUSCO scores (Table 1).
Consistent with the raw short read data, we detected an **extreme level (how much?)** of repeats in the single individual, long read genome (Table 1).
To improve assembly across long repeats, we produced a second ONT dataset with longer reads from HMW DNA from two pools of 20 individuals each. 
Sequencing these samples on the MinION sequencer produced a total of 12.0 GB of quality-filtered reads with an *N*~50~ length of 19.5 KB.
Assembling the long reads from the pooled sample alone resulted in a more contiguous genome, but with lower BUSCO scores (Table 1).
We constructed a combined, long-read genome using the pooled, long-read dataset for contig construction, and the single-individual, long-read dataset for assembly polishing.
This improved the BUSCO scores, but produced a large number of redundant contigs (Table 1), presumably because of the high rate of heterozygosity in the pooled, long-read dataset.
Finally, we used the PCR-free, short read sequencing data from a single individual with the Purge Haplotigs pipeline to remove redundant contigs from the combined long read assembly [@roachPurgeHaplotigsAllelic2018].
This resulted in a final draft assembly of 1.1 GB with an *N*~50~ length of 122.3 kb and a BUSCO completeness of 83.9%.

Short read assembly was not possible with this genome because of the extreme repeat content.
The final draft assembly had a repeat content of **67.8%** (Table 1), with a maximum repeat size of 17.7 kb and a repeat *N*~50~ length of 485 bp.
The non-repetitive regions (*i.e.* the gaps between repeats) had an *N*~50~ length of 1066 bp.
Third generation (long read) sequencing enabled us to assemble a draft genome, but we expect gaps in the assembly to exist at larger repeat regions that were not covered by long reads.

```table
---
caption: '**Table 1**. Assembly statistics for the final draft genome and intermediate assemblies. n.d.: not determined.'
grid_tables: True
header: True
alignment: RCCCCC
table-width: 1
include: tables/genome_table.csv
---
```

### Genetic variation between NZ weevils associates with a geographical cline

To find regions of the genome associated with genetic differentiation between weevil populations, we mapped our SNP catalog against our draft genome.

- `dapc` of weevil populations showing N-S cline (Tom)
- SNPs associated with difference between groups (Marissa)
- signs of selection in the genome (?)

### New Zealand population of Argentine stem weevils is large and diverse, with multiple introductions

- lack of genetic structure (?)
- historical Ne, if we can (?)
