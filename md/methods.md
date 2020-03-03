## Materials and methods

### Collections *etc*. for GBS

Weevils were collected from blah

### GBS sequencing and processing

DNA was extracted blah

### Genome assembly

An **Illumina TruSeq PCR-free?** library was generated from DNA extracted from a single, male Argentine stem weevil (**moar deets**).
A total of **X GB** of paired-end 100 b and paired-end 150 b reads were generated from the TruSeq PCR-free library.
After removing common sequencing contaminants and trimming adaptor sequences using BBMap (**ref**), a short-read-only genome was assembled with meraculous [**ref**].

- WGA of single indiv
- ONT stuff
- Assembly tricks
- Analysis (BUSCO, RepeatModeller)

### Genome-based analyses *e.g.* *F*~ST~

Catalog was mapped with bwa mem etc.

### Reproducibility and data availability

Raw sequence data for the ASW genome are hosted at the National Center for Biotechnology Information Sequence Read Archive (NCBI SRA) under accession **TBA**.
The code we used to assemble the ASW genome is hosted at [github.com/TomHarrop/asw-flye-withpool](https://github.com/TomHarrop/asw-flye-withpool).
We used `snakemake` [@kosterSnakemakeScalableBioinformatics2012] to arrange analysis steps into workflows and monitor dependencies, and `Singularity` [@kurtzerSingularityScientificContainers2017]make      to capture the computing environment.
The final results and all intermediate steps can be reproduced from the raw data with a single command using `snakemake` and `Singularity`.
The source for this manuscript is hosted at [github.com/TomHarrop/asw-gbs-genome-paper](https://github.com/TomHarrop/asw-gbs-genome-paper).
