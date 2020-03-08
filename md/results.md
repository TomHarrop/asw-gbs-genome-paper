## Results

### Variation in NZ populations of Argentine stem weevil

To measure the variation in NZ populations of ASW, we collected individuals from 7 sites in the North Island and 5 sites in the South Island of New Zealand (Figure 1A).
We genotyped each individual separately using a modified genotyping-by-sequencing (GBS) protocol (**Are we calling it gbs? Ref for the protocol used by AgResearch?**; @elshireRobustSimpleGenotypingbySequencing2011).
We found lots of variation.

![
**Figure 1A.**
Weevil sampling locations.
We collected Argentine stem weevils from 4 locations in the North Island and 7 locations in the South Island of New Zealand.
The number of weevils genotyped from each location is show on the map.
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
 ](fig/location_map.pdf) 

![**Figure 1B.**
B. Pricipal components analysis showing first two principal components.
C. Some figure showing the high heterozygosity.](/home/tom/Projects/stacks-asw/dapc.pdf)

### The Argentine stem weevil genome

To find genomic loci associated with between-population variation, we constructed a draft assembly of the ASW genome.
We initially attempted assembly from a single individual using PCR-free, short read sequencing.
This resulted in a fragmented assembly with low BUSCO scores (Table 1).
Because *k*-mer analysis on the raw reads suggested repeat content greater than 30% and high rate of heterozygosity (**Supporting Information**), we then attempted to produce a long-read genome assembly using whole-genome amplification (WGA) of high molecular weight (HMW) DNA from a single individual, followed by sequencing on the Oxford Nanopore Technologies (ONT) MinION sequencer.
We produced 29.8 GB of quality-filtered reads with an *N*~50~ length of 9.0 KB.
The low read *N*~50~ length is caused by debranching of the amplified DNA by T7 Endonuclease I, which is necessary following multiple displacement amplification (see methods).
Assembling the single individual, long read genome resulted in improved contiguity and BUSCO scores (Table 1).
We detected an extreme level of repeats in the single individual, long read genome (Table 1).
To improve assembly of long repeat regions, we produced a second ONT dataset with longer reads from HMW DNA from a two pools of 20 individuals each. 
Sequencing these samples on the MinION sequencer produced a total of 12.0 GB of quality-filtered reads with an *N*~50~ length of 19.5 KB.
**For completeness, assemble the pooled genome alone?**.
We constructed a combined, long-read genome using the pooled, long-read dataset for contig construction, and the single-individual, long-read dataset for assembly polishing.
This resulted in a more contiguous assembly, but a large number of redundant contigs (Table 1), presumably because of the high rate of heterozygosity in the pooled, long-read dataset.
We produced a final draft assembly of 1.1 GB (Table 1) by using the PCR-free, short read sequencing data from a single individual with the purge_haplotigs pipeline to remove redundant contigs from the combined long read assembly [@roachPurgeHaplotigsAllelic2018].
**Something about the repetitiveness**.
We used our final draft genome for all subsequent analyses.

```table
---
caption: '**Table 1**. Assembly statistics for draft and intermediate assemblies.'
grid_tables: True
header: True
alignment: RCCCCC
table-width: 1
include: tables/genome_table.csv
---
```

### Variation associates with a North-South cline

etc. etc.

