## Results


### The Argentine stem weevil genome is repetitive and polymorphic

To construct a reference for genotyping populations of Argentine stem weevils, we produced a draft assembly of the ASW genome.
We initially attempted assembly from a single individual using PCR-free, short read sequencing.
This resulted in a fragmented assembly with low BUSCO scores (Table 1).
*k*-mer analysis on the raw short reads suggested 2.1 polymorphisms per 100 bp and a genomic repeat content of at least 28% in the individual we sequenced (**Supporting Information**).
We then attempted to produce a long-read genome assembly using whole-genome amplification (WGA) of high molecular weight (HMW) DNA from a single individual, followed by sequencing on the Oxford Nanopore Technologies (ONT) MinION sequencer.
We produced 29.8 GB of quality-filtered reads with an *N*~50~ length of 9.0 KB.
The raw read *N*~50~ length was reduced by debranching of the amplified DNA by T7 Endonuclease I, which is necessary following multiple displacement amplification (see methods).
Assembling the single individual, long read genome resulted in improved contiguity and BUSCO scores (Table 1).
Consistent with the raw short read data, we detected an **extreme level (how much?)** of repeats in the single individual, long read genome (Table 1).
To improve assembly across long repeats, we produced a second ONT dataset with longer reads from HMW DNA from two pools of 20 individuals each. 
Sequencing these samples on the MinION sequencer produced a total of 12.0 GB of quality-filtered reads with an *N*~50~ length of 19.5 KB.
Assembling the longer reads generated from the pooled sample alone resulted in a more contiguous genome, but with lower BUSCO scores (Table 1).
We constructed a combined, long-read genome using the pooled, long-read dataset for contig construction, and the single-individual, long-read dataset for assembly polishing.
This improved the BUSCO scores, but produced a large number of redundant contigs (Table 1), presumably because of the high rate of heterozygosity in the pooled, long-read dataset.
Finally, we used the PCR-free, short read sequencing data from a single individual with the Purge Haplotigs pipeline to remove redundant contigs from the combined long read assembly [@roachPurgeHaplotigsAllelic2018].
This resulted in a final draft assembly of 1.1 GB with an *N*~50~ length of 122.3 kb and a BUSCO completeness of 83.9%.

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


### Variation in NZ populations of Argentine stem weevil

To measure genetic variation in invasive New Zealand populations of ASW, we collected individuals from 10 sites across the North and South Islands of New Zealand (Figure 1A).
We genotyped individuals with a modified genotyping-by-sequencing (GBS) protocol [@elshireRobustSimpleGenotypingbySequencing2011].
After strict filtering of the raw GBS data, we mapped reads from each individual against our draft genome and used gstacks to assemble loci [@catchenStacksAnalysisTool2013].
For analysis, we removed loci with more than two alleles, minor allele frequency less than 0.05, or missing genotypes in more than 20% of individuals.
We also removed individuals missing genotypes at more than 20% of loci.
Our final dataset comprised 7--15 individuals per location (total 116), genotyped at 20,445 loci containing 4,363 biallelic sites.
The mean observed heterozygosity for these sites ranged from 0.18--0.21 across populations (Figure 1B), and pairwise *F*~ST~ values between populations ranged from 0.024--0.051 (Figure 1C).
Principal components analysis (PCA) of the genotypes revealed overlapping populations of ASW, with 9.4% of total variance explained by the first two components (Figure 1D).
These results suggest that NZ populations of ASW are highly heterozygous, but the variation is not highly structured between populations.
This is consistent with a large effective population size and high gene flow between populations.

![
**Figure 1.**
Genetic diversity in NZ populations of Argentine stem weevil.
**A** Weevil sampling locations.
We collected Argentine stem weevils from 4 locations in the North Island and 6 locations in the South Island of New Zealand.
The number of weevils genotyped from each location is shown on the map.
Greymouth is on the South Island but on the North side of the Alpine divide.
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
**B** Mean observed heterozygosity (*H*~O~) across 4,363 variant sites for each population.
**C** Pairwise *F*~ST~ values between populations.
**D** Pricipal components analysis (PCA) of 116 individuals genotyped at 4,363 biallelic sites.
The first two principal components (PC1 and PC2) are shown.
The populations overlap on PC1 and PC2, but weevils sampled from higher latitudes tend to have lower scores on PC1.
PC1 and PC2 together explain 9.4% of variance in the dataset, indicating a high level of unstructured genetic variation in weevil populations.
](fig/figure_1.pdf) 

### Genetic variation is not associated with parasitism by a biocontrol agent

To detect variation associated with parasitism by *Microctonus hyperodae* (*i.e.* selection exerted by the biocontrol agent), we genotyped weevils that had also been tested for the presence of a parasitoid larva.
These weevils were collected from **Lincoln, New Zealand?** and **Ruakura, New Zealand?**, because of the decline in parasitism rate recorded at these locations [@tomasettoIntensifiedAgricultureFavors2017].
After filtering, we genotyped **X** parasitised weevils and **Y** weevils without a detected parasitoid at the same 20,445 loci used for the geographical samples, which contained 4,579 biallelic sites in this second dataset.
**We did not detect SNPs that were associated with the presence of a parasitoid larva, although we were able to detect SNPs that were associated with the location the weevil was collected.
Figure to show this.**
This suggests that the developing resistance of the weevil to biocontrol [@tomasettoIntensifiedAgricultureFavors2017] is not related to within-population genetic variation that allows some weevils to avoid parasitism or its effects.

### Genetic variation between NZ weevils associates with a geographical cline

Although geographic location explains a small proportion of the genetic variance between ASW individuals, parasitism rates vary at different sites in NZ (**ref**).
We addressed this by testing whether differences between populations were related to selection in defined regions of the genome.
We used discriminant analysis of principal components to find genetic variability associated with differences between populations (DAPC; @jombartDiscriminantAnalysisPrincipal2010).
The major linear discriminant, which explains 97.7% of between-population variations, separates populations from North and South of the Alpine divide (Figure 2A), although admixture was evident in all populations (Figure 2B).
Differences in allele frequencies between weevils collected from North and South of the Alpine divide suggest that **x** regions of the genome may be under **balancing/purifying** selection (**run BayeScan**).

![
**Figure 2**.
**A** Discriminant analysis of principle components (DAPC) of 116 individuals genotyped at 4,363 biallelic sites.
Linear discriminant 1 (LD1) explains 97.7% of between-group variability.
Individuals from North of the Alpine divide (see Figure 1) have negative coordinates on LD1, whilst individuals from South of the Alpine divide have positive coordinates.
**B** Membership probabilities for each individual.
All populations contain individuals with high posterior probabilities of membership to other populations, consistent with admixture (**?**).
](fig/figure_2.pdf)

![
Regions of low variation (high *F*~ST~) in the stem weevil genome.
Needs to be redone with Bayescan.
](fig/whole_genome_fst.pdf)

![
Regions of low variation (high *F*~ST~) on the longest contig.
Doesn't work with large distances between loci.
](fig/single_contig_fst.pdf)

![
Distance between successive SNPs.
](fig/distance_plot.pdf)

### New Zealand population of Argentine stem weevils is large and diverse, with multiple introductions

[No] evidence for reduced diversity since/on introduction of invasive populations to NZ. We can't do historical demographics / *N*~e~ because of the distance between GBS loci.
