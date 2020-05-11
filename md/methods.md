## Materials and methods

### Weevil sampling

From Goldson & co:

- weevil collection details for geographic survey
- collection and processing/dissection details for parasitised *vs*. unparasitised expt

The map was plotted with the ggmap package for ggplot2 [@kahleGgmapSpatialVisualization2013].

### Reduced-representation genome sequencing and processing

From AgResearch:

- details on DNA extraction, GBS pipeline and sequencing

We used a strict processing pipeline to prepare the raw GBS reads for locus assembly.
Samples were demultiplexed with zero allowed barcode mismatches to 91--93 b reads, depending on barcode length.
Reads were trimmed by searching for adaptors with a minimum match of 11 b.
Reads shorter than 80 b after trimming were discarded.
All remaining reads were truncated to 80 b to account for unmatched adaptor sequence < 11 b that may have been present at the end of reads.
To remove overamplified samples, we calculated the GC content for each library and discarded samples with median read GC > 45%.
We followed the recommended steps for optimising parameters [@parisLostParameterSpace2017; @rochetteDerivingGenotypesRADseq2017] before assembling loci *de novo* using Stacks [@catchenStacksAnalysisTool2013].
The code we used to process the raw reads, optimise parameters and assemble loci is hosted at [github.com/TomHarrop/stacks-asw](https://github.com/TomHarrop/stacks-asw) and [github.com/MarissaLL/asw-para-matched](https://github.com/MarissaLL/asw-para-matched).

### Genome assembly

To produce the short read dataset, an Illumina TruSeq PCR-free 350bp insert library was generated from DNA extracted from a single, male Argentine stem weevil collected from endophyte-free hybrid ryegrass (*Lolium perenne* × *Lolium multiflorum*) at Lincoln, New Zealand.
Library preparation and sequencing were performed by Macrogen Inc. (Seoul, Republic of Korea).
A total of 158 GB of 100 b and 150 b paired-end reads were generated from the TruSeq PCR-free library.
After removing common sequencing contaminants and trimming adaptor sequences using BBTools [@bushnellBBMapFastAccurate2014], the short-read-only genome was assembled with meraculous [@chapmanMeraculousNovoGenome2011; @chapmanMeraculous2FastAccurate2016; @goltsmanMeraculous2DHaplotypesensitiveAssembly2017].
Reproducible code for assembling the short-read dataset and assessing the assemblies is hosted at [github.com/tomharrop/asw-nopcr](https://github.com/tomharrop/asw-nopcr).

To produce long reads from a single individual, we produced high molecular weight DNA from a single, male ASW collected from Ruakura, New Zealand, using a modified  QIAGEN Genomic-tip 20/G extraction protocol [@harropHMWDNAExtraction2018].
We amplified the DNA using Φ29 multiple displacement amplification (QIAGEN REPLI-g Midi Kit) and debranched the amplified DNA using T7 Endonuclease I (New England Biolabs) according to the Oxford Nanopore Technologies Premium whole genome amplification protocol version WGA_kit9_v1.
Debranching reduced the raw read *N*~50~ length to 9.0 KB.
Amplified DNA was sequenced on 6 R9.4.1 flowcells using a MinION Mk1B sequencer (Oxford Nanopore Technologies).
We also extracted high molecular weight DNA from three pools, each of 20 unsexed individuals collected from Ruakura, New Zealand.
We sequenced this pooled DNA on 5 R9.4.1 flowcells, following the Genomic DNA by Ligation protocol (SQK-LSK109; Oxford Nanopore Technologies).
We removed adaptor sequences from the long reads with Porechop 0.2.4 ([github.com/rrwick/Porechop](https://github.com/rrwick/Porechop)) and assembled with Flye 2.6 [@kolmogorovAssemblyLongErrorprone2019].
Reproducible code for assembling and assessing the long-read ASW genomes is hosted at [github.com/TomHarrop/asw-flye-withpool](https://github.com/TomHarrop/asw-flye-withpool).

All genome assemblies were assessed by size and contiguity statistics and BUSCO analysis [@simaoBUSCOAssessingGenome2015]. 
Redundant contigs were removed from the combined, long read assembly with Purge Haplotigs 0b9afdf [@roachPurgeHaplotigsAllelic2018] using a low, mid and high cutoff of 60, 120 and 190, respectively.
We attempted to use RepeatModeler 2.0.1 [@smitRepeatModelerOpen12015] and RepeatMasker 4.1.0 [@smitRepeatMaskerOpen42015] from the Dfam TE Tools Container v1.1 ([github.com/Dfam-consortium/TETools](https://github.com/Dfam-consortium/TETools)) to estimate the repeat content of the long read genomes, but >500M high-scoring Segment Pairs (HSPs) were identified and RepeatModeler did not finish after running for 4 weeks with 144 GB of physical RAM.

### Genome-based analyses, *F*~ST~, etc. etc.

- Catalog mapping *e.g.* `bwa mem`

### Reproducibility and data availability

Raw sequence data for the ASW genome are hosted at the National Center for Biotechnology Information Sequence Read Archive (NCBI SRA) under accession **TBA**.
We used `snakemake` [@kosterSnakemakeScalableBioinformatics2012] to arrange analysis steps into workflows and monitor dependencies, and `Singularity` [@kurtzerSingularityScientificContainers2017] to  capture the computing environment.
Using the code repositories listed in each methods section, the final results can be reproduced from the raw data with a single command using `snakemake` and `Singularity`.
The source for this manuscript is hosted at [github.com/TomHarrop/asw-gbs-genome-paper](https://github.com/TomHarrop/asw-gbs-genome-paper).
