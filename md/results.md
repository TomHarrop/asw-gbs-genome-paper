## Results


### The Argentine stem weevil genome is repetitive and polymorphic

To construct a reference for genotyping populations of Argentine stem weevils, we produced a draft assembly of the ASW genome.
We initially attempted assembly from a single individual using PCR-free, short read sequencing.
This resulted in a fragmented assembly with low BUSCO scores (Table 2).
*k*-mer analysis on the raw short reads suggested 2.1 polymorphisms per 100 bp and a genomic repeat content of at least 28% in the individual we sequenced (**Supporting Information**).
We then attempted to produce a long-read genome assembly using whole-genome amplification (WGA) of high molecular weight (HMW) DNA from a single individual, followed by sequencing on the Oxford Nanopore Technologies (ONT) MinION sequencer.
We produced 29.8 GB of quality-filtered reads with an *N*~50~ length of 9.0 KB.
Assembling the single individual, long read genome resulted in improved contiguity and BUSCO scores compared to the short-read assembly (Table 2).
Consistent with the raw short read data, the single individual, long read genome was at least 70% repetitive (Table 2).
To improve assembly across long repeats, we produced a second ONT dataset with longer reads from HMW DNA from two pools of 20 individuals each, without amplification.
Sequencing these samples on the MinION sequencer produced a total of 12.0 GB of quality-filtered reads with an *N*~50~ length of 19.5 KB.
Assembling the longer reads generated from the pooled sample alone resulted in a more contiguous genome, but with lower BUSCO scores (Table 2).
We constructed a combined, long-read genome using the pooled, long-read dataset for contig construction, and the single-individual, long-read dataset for assembly polishing.
This improved the BUSCO scores, but produced a large number of redundant contigs (Table 2), presumably because of the high rate of heterozygosity in the pooled, long-read dataset.
We then used the PCR-free, short read sequencing data from a single individual with the Purge Haplotigs pipeline to remove redundant contigs from the combined long read assembly [@roachPurgeHaplotigsAllelic2018].
This resulted in a final draft assembly of 1.1 GB with an *N*~50~ length of 122.3 kb and a BUSCO completeness of 83.9%.

<!--
|----------:|:-----|:-----|:-----|:-----|:-----|
 -->

: **Table 2**.
Assembly statistics for the final draft genome and intermediate assemblies.  
1. We estimated repeat content from a subset of contigs in the assembly (see Methods).  
n.d.: not determined.

| | Short read | Single individual, long read | Pooled, long read | Combined, long read | Final draft |
|----------:|:-----|:-----|:-----|:-----|:-----|
|               Assembly length (Gb) | 1.3        | 1.2                          | 1.2               | 1.7                 | 1.1         |
|                            *N*~50~ | 53046      | 4523                         | 2958              | 5281                | 2681        |
|                *N*~50~ length (kb) | 7.1        | 74.4                         | 112.6             | 86.4                | 122.3       |
|   Complete, single-copy BUSCOs (%) | 32.7       | 72.2                         | 71.0              | 69.2                | 78.8        |
| Complete, multiple-copy BUSCOs (%) | 17.2       | 7.5                          | 5.9               | 17.4                | 5.1         |
|                 Minimum^1^ repeat content (%) | n.d. | 71.0 | 71.4 | 71.4 | 71.3 |

### Genetic variation is associated with geography in NZ populations of Argentine stem weevil 

To measure genetic variation in invasive New Zealand populations of ASW, we collected individuals from 10 sites across the North and South Islands of New Zealand (Figure 1A).
We genotyped 183 individuals with a modified genotyping-by-sequencing (GBS) protocol [@elshireRobustSimpleGenotypingbySequencing2011].
After strict trimming and filtering of the raw GBS data, we mapped reads from each individual against our draft genome and used gstacks to assemble loci [@catchenStacksAnalysisTool2013].
For analysis, we removed loci with more than two alleles, minor allele frequency less than 0.05, or missing genotypes in more than 20% of individuals.
We also removed individuals missing genotypes at more than 20% of loci.
The filtered dataset comprised 7--15 individuals per location (total 116), genotyped at 52,051 biallelic SNPs.
The mean observed heterozygosity ranged from 0.18--0.21 across populations (Figure 1B), and pairwise *F*~ST~ values between populations ranged from 0.024--0.051 (Figure 1C).
For principal components analysis (PCA), we pruned the dataset to 18,715 biallelic SNPs that were not in linkage disequilibrium, using an r^2^ threshold of 0.1.
PCA of genotypes at these sites revealed overlapping populations of ASW, with 9.2% of total variance explained by the first two components (Figure 1D).
These populations of ASW are highly heterozygous, but the low proportion of total variance explained by the major principal components suggests that variation is not highly structured between populations.
This is consistent with a large effective population size and gene flow between populations.
To find variance between populations, we used discriminant analysis of principal components (DAPC) on the same set of pruned SNPs [@jombartDiscriminantAnalysisPrincipal2010].
The major linear discriminant, which explains 96.7% of between-population variation, separates populations from North and South of the Main Divide (Figure 1E), although we found evidence of mixing in all populations except Lincoln (Figure 1F).
Although the PCA suggests that the majority of the total variance is not structured, the DAPC indicates a degree of genetic isolation between populations from North and South of the Main Divide.

![
**Figure 1.** Caption next page.
](fig/figure_1.pdf)

\beginfigurecaption

**Figure 1.**
Genetic diversity in NZ populations of Argentine stem weevil.
**A** Weevil sampling locations.
We collected Argentine stem weevils from 4 locations in the North Island and 6 locations in the South Island of New Zealand.
Greymouth is in the South Island, but North of the Main Divide, which runs along the Southern Alps and divides the South Island.
The number of weevils genotyped from each location is shown on the map.
Map tiles by [Stamen Design](http://stamen.com) under [CC BY 3.0](http://creativecommons.org/licenses/by/3.0) with data by [OpenStreetMap](http://openstreetmap.org) under [ODbL](http://www.openstreetmap.org/copyright).
**B** Mean observed heterozygosity for each population.
**C** Pairwise *F*~ST~ values between populations.
**D**  Principal components analysis (PCA) describing total variability and **E** discriminant analysis of principle components (DAPC) describing between-population variability of 116 individuals genotyped at 18,715 biallelic sites.
In the PCA (**D**), populations overlap on the first two principal components (PC1 and PC2), but weevils sampled from higher latitudes have lower scores on PC1.
PC1 and PC2 together explain 9.2% of variance in the dataset, indicating a high level of unstructured genetic variation in weevil populations.
In the DPAC (**E**), the major linear discriminant (LD1) explains 96.7% of between-group variability.
LD1 splits individuals from North and South of the Main Divide.
LD2 separates Lincoln individuals from other individuals.
**F** Posterior probability of group assignment for each individual.
All populations contain individuals with high posterior probabilities of membership to other populations, consistent with gene flow between populations.
We did not detect evidence of gene flow between populations from North and South of the Main Divide.
Individuals sampled from Lincoln had the lowest posterior probabilities of membership to other populations.

\endfigurecaption

### Genetic variation is not associated with parasitism by *M. hyperodae*

To detect large-effect variants associated with susceptibility to parasitism by *M. hyperodae*, we genotyped weevils that had also been tested for the presence of a parasitoid larva.
We used a total of 200 individuals, collected from Lincoln and Ruakura (Table 3), because of the decline in parasitism rate recorded at these locations [@tomasettoIntensifiedAgricultureFavors2017].
The weevils were examined for a parasitoid larva and genotyped at the same loci used for the geographical survey.
After filtering and pruning sites in linkage disequilibrium, we used 19,482 SNPs for PCA and DAPC in 95 parasitised inviduals and 84 individuals where a parasitoid was not detected (Table 3).
We did not detect any genetic differentiation associated with the presence of a parasitoid, either within populations or between populations, or any evidence of skewed allele frequencies in these groups using BayeScan (lowest *Q*-value 0.97).

: **Table 3**. Number of parasitised and unparasitised weevils from Ruakura and Lincoln.

| Location | Parasitoid | Number genotyped | Number after filtering |
|----------:|----------|-----|-----|
| Ruakura | Present | 50 | 46 |
| Ruakura | Not detected | 50 | 40 |
| Lincoln | Present | 50 | 49 |
| Lincoln | Not detected | 50 | 44 |

>>>
@ Marissa and Peter - there are some contigs that come up using XPEHH for these groups.
There's a contig (contig_11238) full of transcription factors with a single locus that has a high positive XPEHH score, but this would suggest selection in the *parasitised* group.
There is one contig (contig_5955) with a large negative XPEHH (selection in non-parasitised group) but the genes are not interesting.
I think the XPEHH results might be spurious because the low number of markers per contig lead to dodgy phasing, so I'm thinking of removing XPEHH from the following section.
I've left them in this version to get your thoughts.


### Genetic differentiation between ASW populations North and South of the Main Divide

Although we did not detect variation associated with presence of a parasitoid, parasitism rate varies across sites in NZ [@tomasettoIntensifiedAgricultureFavors2017].
To investigate the genetic differentiation between regions, we grouped individuals that were collected from North and South of the Main Divide (Figure 1).
The two groups had a mean *F*~ST~ of 0.013.
We detected 47 SNPs with skewed allele frequencies across 24 contigs in the draft genome with BayeScan (Figure 2).
The contigs containing these SNPs had a total of 3--36 SNPs, and all 47 of the detected SNPs had positive α values, suggesting diversifying selection (Table 2).
Using an orthogonal method, 32 SNPs across 5 contigs had outlying cross-population extended haplotype homozygosity (XPEHH) scores [@sabetiGenomewideDetectionCharacterization2007; @gautierRehhPackageDetect2012].
Both methods identified putative SNPs under selection an overlapping region on contig_40523.
These sites had high α values and positive XPEHH scores, suggesting diversifying selection in the North group.
We identified four genes on contig_40523.
None had characterized functions in insects.

![
**Figure 2**.
**A** Regions of the draft ASW genome that have altered allele frequencies between populations from North and South of the Main Divide.
47 SNPs on 24 contigs have altered allele frequencies, using the arbitrary *Q*-value cutoff of 0.01.
**B** Models of population demographics and results (in progress).
](fig/single_contig_fst.pdf)

\clearpage

: **Table 2**.
Number of SNPs under selection using BayeScan [@follGenomeScanMethodIdentify2008] (*Q* < 0.01) or cross-population extended haplotype homozygosity (XPEHH) analysis [@sabetiGenomewideDetectionCharacterization2007; @gautierRehhPackageDetect2012] (-log~10~*p* > 4). α is BayeScan's locus-specific component of *F*~ST~ coefficient [@follGenomeScanMethodIdentify2008]. Positive values suggest diversifying selection. Positive XPEHH scores suggest selection in the North group, and negative scores suggest selection in the South group.

+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|         Contig | Total | BayeScan | BayeScan region    | α            | XPEHH | XPEHH region       | XPEHH          |
|                | SNPs  | SNPs     |                    |              | SNPs  |                    |                |
+================+=======+==========+====================+==============+=======+====================+================+
|   contig_40523 | 26    | 5        | 103,989 -- 111,755 | 1.93 -- 2.14 | 2     | 111,724 -- 111,783 | 5.34 -- 5.83   |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_11164 | 23    | 4        | 60,487 -- 179,797  | 1.84 -- 2.05 | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
| scaffold_43207 | 11    | 4        | 102,783 -- 102,811 | 1.70 -- 2.14 | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|    contig_2677 | 22    | 3        | 109,260 -- 110,069 | 1.79 -- 1.99 | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_18336 | 20    | 3        | 233,287 -- 342,618 | 1.90 -- 1.99 | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_12006 | 10    | 3        | 46,975 -- 47,031   | 2.09 -- 2.15 | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_13287 | 10    | 3        | 58,727 -- 58,738   | 1.68 -- 1.98 | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_39072 | 10    | 3        | 55,060 -- 55,126   | 2.06 -- 2.14 | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_37676 | 17    | 2        | 47,912 -- 47,954   | 2.01 -- 2.03 | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|    contig_4080 | 13    | 2        | 26,024 -- 26,027   | 1.78 -- 1.79 | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_23638 | 6     | 2        | 118,602 -- 118,616 | 2.08 -- 2.15 | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|    contig_8456 | 36    | 1        | 88,819             | 1.92         | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|    contig_1196 | 24    | 1        | 393,177            | 1.68         | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_20252 | 20    | 1        | 34,278             | 1.87         | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_27115 | 20    | 1        | 111,838            | 1.94         | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|    contig_3057 | 13    | 1        | 272,534            | 1.91         | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_23312 | 12    | 1        | 171,714            | 1.95         | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|     contig_202 | 8     | 1        | 80,251             | 2.03         | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_14933 | 7     | 1        | 80,478             | 1.98         | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_19450 | 6     | 1        | 37,951             | 2.39         | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|     contig_205 | 6     | 1        | 28,713             | 2.13         | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_21253 | 6     | 1        | 43,048             | 1.76         | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_28985 | 6     | 1        | 22,034             | 2.01         | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|   contig_12091 | 3     | 1        | 43,431             | 2.02         | 0     |                    |                |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|    contig_1525 | 45    | 0        |                    |              | 18    | 30,186 -- 47,858   | -9.56 -- -5.17 |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|    contig_5179 | 41    | 0        |                    |              | 9     | 46,573 -- 48,037   | -7.02 -- -5.48 |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|      contig_18 | 52    | 0        |                    |              | 2     | 488,821 -- 488,823 | -6.85 -- -5.39 |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+
|      contig_71 | 22    | 0        |                    |              | 1     | 247,010            | 7.34           |
+----------------+-------+----------+--------------------+--------------+-------+--------------------+----------------+

### Repeated/large/separate incursions of ASW into New Zealand

This is in progress.
We're testing 3 main models:

- model 1: single introduction then bottleneck, spread, diversification, and gene flow.
- model 2: **separate introductions** to North and South, with bottlenecks and gene flow between populations.
- model 3: separate introductions, then bottlenecks, from **different source populations** to North and South, with bottlenecks and gene flow between populations.
- all of the above but without bottlenecks to simulate large or repeated incursions.

