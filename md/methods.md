## Materials and methods

### Weevil sampling

We collected regional ASW samples from commercially-farmed ryegrass / white clover (*Trifolium repens* L.) (Fabaceae: Fabales) pastures using a suction device to collect ground litter (Table 1).
Weevils were extracted from the litter in the laboratory.
The locations are also illustrated in Figure 1.
The map was plotted with the ggmap package for ggplot2 [@kahleGgmapSpatialVisualization2013] using map tiles by
[Stamen Design](http://stamen.com) under [CC BY 3.0](http://creativecommons.org/licenses/by/3.0) with data by [OpenStreetMap](http://openstreetmap.org) under [ODbL](http://www.openstreetmap.org/copyright).

For the comparison between parasitised and unparasitised weevils, samples were collected from ryegrass/clover pasture at Ruakura and Lincoln (as in Table 1) in August 2017.
These samples were dissected as per Goldson and Emberson [@goldsonReproductiveMorphologyArgentine1981a] to determine whether they were parasitised.
After dissection, heads were removed and used for genotyping.

: **Table 1**. 
Weevil collection locations (see also Figure 1).  
n.d.: not determined.

| Location      | GPS co-ordinates (lat, lon)           | Date collected | Parasitism (%) |
|----------:|-----|-----|-----|
| Coromandel    | -37.20194, 175.59417 | June 2015 | 19       |
| Ruakura       | -37.76750, 175.32361 | June 2015 | 17       |
| Taranaki      | -39.61500, 174.30278 | July 2015 | 21       |
| Wellington    | -41.13647, 175.35163 | July 2015 | 42       |
| Greymouth     | -42.89506, 172.71926 | September 2016 | 36       |
| Lincoln       | -43.64397, 172.44292 | July 2014 | 19       |
| Ophir         | -45.10955, 169.58753 |  August 2017 | n.d.        |
| Mararoa Downs | -45.50672, 167.97596 | May 2016 | < 5         |
| Mossburn      | -45.66966, 168.23884 | January 2016 | 0        |
| Fortrose      | -46.57064, 168.79993 | November 2016       | < 5         |

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

All genome assemblies were assessed by size and contiguity statistics and BUSCO analysis [@simaoBUSCOAssessingGenome2015]. 
Redundant contigs were removed from the combined, long read assembly with Purge Haplotigs 0b9afdf [@roachPurgeHaplotigsAllelic2018] using a low, mid and high cutoff of 60, 120 and 190, respectively.

We were not able to estimate repeat content in the full genomes, because RepeatModeler 2.0.1 [@smitRepeatModelerOpen12015] identified >500M high-scoring Segment Pairs (HSPs) and did not finish after running for 6 weeks with ~200 GB of physical RAM (results not shown).
We estimated repeat content by subsetting the assemblies using the leave-one-out alignment method implemented in funannotate clean 1.7.4 [@jonloveNextgenusfsFunannotateFunannotate2020].
We then used RepeatModeler 2.0.1 [@smitRepeatModelerOpen12015] and RepeatMasker 4.1.0 [@smitRepeatMaskerOpen42015] from the Dfam TE Tools Container v1.1 ([github.com/Dfam-consortium/TETools](https://github.com/Dfam-consortium/TETools)) to estimate the repeat content of the subset assemblies.
We identified less than 1 M HSPs in the subset assemblies, so the repeat content of the subset assemblies is an underestimate of the repeat content in the full assemblies.

Reproducible code for assembling and assessing the long-read ASW genomes is hosted at [github.com/TomHarrop/asw-flye-withpool](https://github.com/TomHarrop/asw-flye-withpool).

We annotated the final, draft assembly with funannotate 1.7.4 [@jonloveNextgenusfsFunannotateFunannotate2020], using five RNA sequencing libraries generated from abdomens and heads of unparasitised adult ASW collected from Lincoln and Ruakura.
Reproducible code for annotating the draft ASW genome is hosted at [github.com/TomHarrop/asw-annotate](https://github.com/TomHarrop/asw-annotate).

### Reduced-representation genome sequencing, processing and analysis

DNA extraction and double digest RADseq [genotyping-by-sequencing, GBS; [@petersonDoubleDigestRADseq2012] were performed by AgResearch, Invermay, New Zealand.
DNA was extracted from individual weevil heads using the ZR-96 Tissue & Insect DNA Kit (Zymo Research, CA, U.S.A.).
The DNA was digested with *Ape*KI and *Msp*I and size selected on a BluePippin (Sage Science, MA, U.S.A.) with a window size of 150--500 bp.
Individual libraries were barcoded and sequencing adaptors were added based on the Elshire method [@elshireRobustSimpleGenotypingbySequencing2011] with modifications [@doddsConstructionRelatednessMatrices2015], and 100 b single-end reads were generated from pooled libraries an Illumina HiSeq 2500 instrument.

We used a strict processing pipeline to prepare the raw GBS reads for locus assembly.
Samples were demultiplexed with zero allowed barcode mismatches to 91--93 b reads, depending on barcode length.
Reads were trimmed by searching for adaptors with a minimum match of 11 b.
Reads shorter than 80 b after trimming were discarded.
All remaining reads were truncated to 80 b to account for unmatched adaptor sequence < 11 b that may have been present at the end of reads.
To remove overamplified samples, we calculated the GC content for each library and discarded samples with median read GC > 45%.
We assembled loci against our draft genome using `gstacks` 2.53 [@catchenStacksAnalysisTool2013].

For analysis, we used bcftools to remove sites with more than 2 alleles, minor allele frequency < 0.05, or missing genotypes in more than 20% of individuals.
After filtering loci, we also removed individuals that were missing genotypes at more than 20% of loci.
We ran the Stacks 2.53 `populations` module [@catchenStacksAnalysisTool2013] to calculate inbreeding (*F*) and heterozygosity statistics.
We used plink 1.9 [@changSecondgenerationPLINKRising2015] to prune sites in linkage disequilibrium for principal components analysis and discriminant analysis of principal components with the adegenet 2.1.2 package for R [@jombartDiscriminantAnalysisPrincipal2010; @rcoreteamLanguageEnvironmentStatistical2015], using the first four principal components.
We used PGDSpider 2.1.1.5 [@lischerPGDSpiderAutomatedData2012] to convert the un-pruned dataset for detection of loci under selection with BayeScan 2.1 [@follGenomeScanMethodIdentify2008].
We analysed cross-population extended haplotype homozygosity with the R package rehh 3.1.0 [@gautierRehhReimplementationPackage2017].
For demographic analysis, we converted the pruned dataset to minor allele (folded) site frequency spectra using easysfs commit c2b26c5 from [github.com/isaacovercast/easySFS](https://github.com/isaacovercast/easySFS).
We estimated likelihood for each demographic model ten times using 
fastsimcoal2 2.6 [@excoffierRobustDemographicInference2013] with 1 million simulations and 60 optimisation cycles per run.
We compared model runs using delta likelihood (maximum observed likelihood - maximum estimated likelihood) and Akaike information criteria [@akaikeNewLookStatistical1974].

All the code we used to process the raw reads, assemble loci and run downstream analyses is hosted at [github.com/TomHarrop/stacks-asw](https://github.com/TomHarrop/stacks-asw), including the parameters and software containers for each step.

### Reproducibility and data availability

Raw sequence data for the ASW genome assembly and annotation and raw GBS reads are hosted at the National Center for Biotechnology Information Sequence Read Archive (NCBI SRA) under accession **TBA**.
We used `snakemake` [@kosterSnakemakeScalableBioinformatics2012] to arrange analysis steps into workflows and monitor dependencies, and `Singularity` [@kurtzerSingularityScientificContainers2017] to  capture the computing environment.
Using the code repositories listed in each methods section, the final results can be reproduced from the raw data with a single command using `snakemake` and `Singularity`.
The source for this manuscript is hosted at [github.com/TomHarrop/asw-gbs-genome-paper](https://github.com/TomHarrop/asw-gbs-genome-paper).
