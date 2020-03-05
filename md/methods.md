## Materials and methods

### Collections *etc*.

Weevils were collected from ...

### Reduced-representation genome sequencing and processing

DNA was extracted ...

The code we used to process the genotyping data is hosted at [github.com/TomHarrop/stacks-asw](https://github.com/TomHarrop/stacks-asw) and [github.com/MarissaLL/asw-para-matched](https://github.com/MarissaLL/asw-para-matched).

Map was plotted with the ggmap package for ggplot2 [@kahleGgmapSpatialVisualization2013].

### Genome assembly

To produce the short read dataset, an Illumina TruSeq PCR-free 350bp insert library was generated from DNA extracted from a single, male Argentine stem weevil collected from endophyte-free hybrid ryegrass (*Lolium perenne* × *Lolium multiflorum*) at **Lincoln, New Zealand (?)**.
Library preparation and sequencing were performed by Macrogen Inc. (Seoul, Republic of Korea).
A total of 158 GB of 100 b and 150 b paired-end reads were generated from the TruSeq PCR-free library.
After removing common sequencing contaminants and trimming adaptor sequences using BBTools [@bushnellBBMapFastAccurate2014], the short-read-only genome was assembled with meraculous [@chapmanMeraculousNovoGenome2011; @chapmanMeraculous2FastAccurate2016; @goltsmanMeraculous2DHaplotypesensitiveAssembly2017].

- WGA of single indiv
- ONT stuff
- Assembly tricks

Genome assemblies were assessed using assembly size and contiguity statistics and BUSCO analysis [@simaoBUSCOAssessingGenome2015]. We used RepeatModeler [@smitRepeatModelerOpen12015] and RepeatMasker [@smitRepeatMaskerOpen42015] to estimate the repeat content of the long read genomes. 

The code we used to assemble and assess the ASW genome is hosted at [github.com/TomHarrop/asw-flye-withpool](https://github.com/TomHarrop/asw-flye-withpool).

### Genome-based analyses, *F*~ST~, etc. etc.

- Catalog mapping *e.g.* `bwa mem`

### Reproducibility and data availability

Raw sequence data for the ASW genome are hosted at the National Center for Biotechnology Information Sequence Read Archive (NCBI SRA) under accession **TBA**.
We used `snakemake` [@kosterSnakemakeScalableBioinformatics2012] to arrange analysis steps into workflows and monitor dependencies, and `Singularity` [@kurtzerSingularityScientificContainers2017] to  capture the computing environment.
Using the code repositories listed in each methods section, the final results can be reproduced from the raw data with a single command using `snakemake` and `Singularity`.
The source for this manuscript is hosted at [github.com/TomHarrop/asw-gbs-genome-paper](https://github.com/TomHarrop/asw-gbs-genome-paper).
