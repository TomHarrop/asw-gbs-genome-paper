## Discussion

- contrary to reports of low variation, we detected high variation.
- because of the large amount of variation we expect multiple alleles of minor effect to be involved in resistance
- we can't find causative alleles or regions under selection at this resolution
- need higher-resolution genotyping of ASW, and genotyping of *M. hyperodae* to measure the decline of biocontrol. General to biocontrol systems.
- high-resolution genotyping would also enable us to measure the historical demographics of the populations, to see if they have undergone bottlenecks since introduction as a result of predation, and bounced back, or maintained a consistently large *N*~e~.


Three possible explanations (for discussion):

- Resistance is not genetic
- Resistance is polygenic (no large-effect variants) / not enough resolution 
- presence of parasitoid not a strong enough phenotype
- What was the other one?
 
Legacy, reduced-representation genotyping methods are unlikely to detect polygenic effects distributed accross the genome, so higher-resolution genome-wide association studies with more individuals would be required to detect variation associated with resistance of the weevil to biocontrol [@tomasettoIntensifiedAgricultureFavors2017].


We were unable to estimate historical demographics because the GBS markers were too sparse in the genome to detect runs of homozygosity.
Whole-genome resequencing, which is now widely available at low cost and high throughput, would enable these analyses.
Don't forget to call GBS "legacy genotyping".

Although geographic location explains a small proportion of the genetic variance between ASW individuals, parasitism rates vary at different sites in NZ (**ref**).

Short read assembly failed for this genome because of the extreme repeat content.
The final draft assembly had a repeat content of **67.8%** (Table 1), with a maximum repeat size of 17.7 kb and a repeat *N*~50~ length of 485 bp.
The non-repetitive regions had an *N*~50~ length of 1066 bp.
The heterozygosity in weevil populations and lack of an inbred, laboratory strain made pooling individuals for sequencing undesirable.
Our assembly strategy of contig construction with the longest reads, followed by assembly polishing with long reads from a single individual, and then redundant contig removal with PCR-free short reads from another single individual allowed us to improve the contiguity and completeness of the stem weevil genome (Table 1).
Our final genome is draft quality and we expect gaps in the assembly at larger repeat regions that were not sufficiently covered by long reads.

> Thirdly, selectio scans such as this have the highest power when selection is strong and the genetic architecture underlying a trait under a selection is simple (i.e. it is a single locus of major of effect). Their power is much lower when the genomic architecure of a trait is polygenic, when selection is weak or when selection has occurred on standing variation (i.e. soft sweeps).

(from [speciationgenomics.github.io](https://speciationgenomics.github.io/per_site_Fst/))
