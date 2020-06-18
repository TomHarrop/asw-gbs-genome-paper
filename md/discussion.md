## Discussion

The purpose of this work was to investigate genetic variation in New Zealand populations of ASW and its possible relationship to resistance to *M. hyperodae*.
Previous reports using randomly amplified polymorphic DNA (RAPD) markers and *cytochrome C oxidase subunit I* (*COI*) sequencing suggested a high degree of genetic similarity and identified a single *COI* haplotype in New Zealand populations [@williamsGeographicalOriginIntroduced1994; @vinkPCRGutAnalysis2013].
In contrast, our results from a genome-wide genotype-by-sequencing (GBS) approach reveal a high level of genetic diversity within and between populations.
We suggest that this standing variation provides an evolutionary advantage to ASW populations in comparison to their biocontrol agent, *M. hyperodae*.
We expect variation to be limited by asexual reproduction in *M. hyperodae* (e.g. [@casanovasAsymmetryReproductionStrategies2018]).
This indicates that genetic variation in both host and biocontrol agent need to be monitored with high-resolution genotyping to maintain success of biological control.
More work will be required to describe the genetic mechanism of resistance and its prevalence in weevil populations, and to measure the amount of variation and population structure in *M. hyperodae*.

ASW was thought to have arrived in New Zealand in the early 20^th^ century, probably via trade in pasture seeds or hay used for feed during stock transit [@brookingSilencesGrassRetrieving2007].
The earlier reports of low genetic diversity, based on traditional molecular markers [@williamsGeographicalOriginIntroduced1994; @vinkPCRGutAnalysis2013],  suggested a limited incursion followed by dispersal and expansion.
Our results provide three main pieces of evidence to update the proposed history of ASW incursions in New Zealand.
The high heterozygosity across populations could be explained by a large initial incursion, repeated introductions, and/or an unusually high mutation rate.
The genetic differentiation between populations from North and South of the Main Divide points to low migration rates between these regions.
Our demographic modelling suggests that the populations expanded to their current effective sizes after already being separated into North and South populations.
The most likely scenario is separate introductions from the same source population to North and South of the Main Divide, with some migration between the two populations.
The power to resolve the possible evolutionary histories that led to the current population structure of New Zealand weevils was provided by the increased resolution of genome-wide genotyping.

Despite the increased resolution of GBS compared to traditional markers, we did not detect regions of the genome associated with parasitism by *M. hyperodae*.
Possible reasons for this include one or more of the following:
*i*. resistance to biocontrol may not be genetic;
*ii*. resistance may be encoded by part of the genome not captured in our assembly;
*iii*. microscopic detection of the parasitoid may not be a strong enough phenotype to separate resistant and susceptible individuals, because individuals without a detectable parasitoid are not necessarily resistant, *e.g.* if they had not been exposed to the parasitoid before collection from the field;
or *iv*. resistance is encoded by multiple regions of small effect, which we were unable to detect in our study.
In model organisms, adaptive evolution in response to selective agents acting within the survivability distribution of a population takes the form of polygenic responses on standing variation [@mckenzieGeneticMolecularPhenotypic1994; @greenCisTransactingVariants2019].
The highest reported parasitism rate of ASW by *M. hyperodae* is 90% [@barkerEarlyImpactEndoparasitoid2006], implying that some individuals in a population survive predation.
In other words, selection by *M. hyperodae* acts within the survivability distribution of ASW populations.
Because we detected a large amount of standing variation in our survey of ASW populations, which may encode phenotypic variation in parasitism survivability, we suggest that a polygenic response is the most probable scenario.
The number of markers yielded by legacy genotyping-by-sequencing approaches provides low power to detect polygenic responses resulting from weak selection on standing variation.
Higher-resolution, genome-wide association studies using whole-genome resequencing with more individuals and a stronger resistance phenotype may allow detection of regions of the genome associated with resistance of the weevils to biocontrol.

Two draft weevil (Coleoptera: Curculionidae) genomes constructed from short reads have been deposited in the NCBI Genome database.
The coffee berry borer, *Hypothenemus hampei*, has a draft genome size of 163 MB [@vegaDraftGenomeMost2015], and the mountain pine beetle, *Dendroctonus ponderosae*, has a draft genome size of 202 MB in males and 213 MB in females [@keelingDraftGenomeMountain2013].
Draft genomes that incorporate long reads have been deposited for the red palm weevil (*Rhynchophorus ferrugineus*; [GCA_012979105.1](https://www.ncbi.nlm.nih.gov/assembly/GCA_012979105.1/)) and the rice weevil (*Sitophilus oryzae*; [GCF_002938485.1](https://www.ncbi.nlm.nih.gov/assembly/GCF_002938485.1/)).
These assemblies are 782 MB and 771 MB, respectively.
Assemblies using long reads capture more of the genome, presumably because larger repeat regions can be assembled.
Our ASW genome of 1.1 GB is larger than other available weevil genomes, and has a high proportion of repetitive sequences.
The contiguity statistics and BUSCO scores indicate draft quality, and we expect gaps in the assembly at larger repeat regions that were not sufficiently covered by long reads.
Our attempt at short-read assembly of the Argentine stem weevil genome was not effective because of the extreme repeat content.
The heterozygosity in weevil populations and lack of an inbred, laboratory strain made pooling individuals for sequencing undesirable.
This is highlighed by the number of multiple-copy genes in the combined, long read assembly.
Our strategy to assemble the ASW genome included contig construction with the longest reads, followed by assembly polishing with long reads from a single individual, and then redundant contig removal with PCR-free short reads from another single individual.
This allowed us to optimise the contiguity and completeness of the genome whilst managing the number of redundant contigs (Table 2 ).

### Conclusion

Our results show that New Zealand populations of ASW have a large amount of heterozygosity, and we suggest that this allowed them to evolve resistance to their biological control agent.
This highlights the need for monitoring biological control systems by genome-wide genotyping.
