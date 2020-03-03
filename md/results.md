## Results

### Variation in NZ populations of Argentine stem weevil

To measure the variation in NZ populations of ASW, we collected samples from X Y Z locations.
We found lots of sweet variation.

### The Argentine stem weevil genome

To determine if between-population variation was related to selection at specific loci, we constructed a draft assembly of the ASW genome.
We initially attempted assembly from a single individual using PCR-free, short-read sequencing.
This resulted in a fragmented assembly with low BUSCO scores (**genome_table**).
Because of the high heterozygosity in the single-individual short-read library (**SI**), we attempted to produce a long-read genome assembly using whole-genome amplification (WGA) of high molecular weight (HMW) DNA from a single individual followed by sequencing on the Oxford Nanopore Technologies (ONT) MinION sequencer.
We produced 29.8 GB of quality-filtered reads with an *N*~50~ length of 9.0 KB.
The low read *N*~50~ length is caused by branching of the genomic DNA during WGA by Φ29 DNA polymerase [**ref**].
Assembling the single-individual, long-read-only genome resulted in improved contiguity and BUSCO scores (**genome_table**).
We detected an extreme level of repeats in the single-individual, long-read-only genome (**genome_table**).
To produce a second ONT dataset with longer reads, we extracted HMW DNA from a pool of **x** individuals.
Sequencing this DNA on the MinION sequencer produced 12.0 GB of reads with an *N*~50~ length of 19.5 KB.
We constructed a draft genome using the pooled, long-read dataset for contig construction, and the single-individual, long-read dataset for assembly polishing.
This resulted in a more contiguous assembly, but a large number of redundant contigs (**genome_table**), presumably because of the high rate of heterozygosity in the pooled, long-read dataset.
After using the short-read, single-individual sequencing data with the purge_haplotigs pipeline to remove redundant contigs (**ref**), we produced a final, draft genome of **X GB** (**genome_table**).
**Something about the repetitiveness**.
We used this draft genome for subsequent analysis.

```table
---
caption: '**genome_table**'
header: True
alignment: RC
table-width: 0.25
markdown: True
include: tables/test_table.csv
---
```

### Variation associates with a North-South cline

etc. etc.

