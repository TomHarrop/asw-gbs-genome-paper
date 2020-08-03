**This repository contains the manuscript source for the following article**:

> Thomas W. R. Harrop, Marissa F. Le Lec, Ruy Jauregui, Shannon E. Taylor, Sarah N. Inwood, Tracey van Stijn, Hannah Henry, et al. 2020. “Genetic Diversity in Invasive Populations of Argentine Stem Weevil Associated with Adaptation to Biocontrol.” Insects 11 (7): 441. [10.3390/insects11070441](https://doi.org/10.3390/insects11070441).

## Data availability

- Sequence data from this article have been deposited with the National Center for Biotechnology Information Sequence Read Archive (SRA) under accession [PRJNA64051]1(https://www.ncbi.nlm.nih.gov/bioproject/640511).

## Reproducibility

- The code we used to assemble the weevil genome from ONT MinION data is hosted at [tomharrop/asw-flye-withpool](https://github.com/tomharrop/asw-flye-withpool).
- Our initial attempts to assemble the genome from short-read (Illumina) data are hosted at [tomharrop/asw-nopcr](https://github.com/tomharrop/asw-nopcr).
- Our `funannotate`-based annotation of the long-read genome is hosted at [tomharrop/asw-annotate](https://github.com/tomharrop/asw-annotate).
- Our processing and analysis of the genotyping-by-sequencing (GBS) data, including `fastsimcoal2` analysis of demographic history and `BayeScan` runs to detect selection, are hosted at [tomharrop/stacks-asw](https://github.com/tomharrop/stacks-asw)
- For all the analysis, we used [`snakemake`](https://snakemake.readthedocs.io/en/stable/) to arrange analysis steps into workflows and monitor dependencies, and [`Singularity`](https://sylabs.io/singularity/) to capture the computing environment.
- The final results in each analysis repo can be reproduced from the raw data using `snakemake` and `Singularity`.

## Contact

- For questions, contact the corresponding authors or open an issue in the GitHub repository.
